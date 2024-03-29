import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_twitter_course/constants/constants.dart';
import 'package:riverpod_twitter_course/core/core.dart';
import 'package:riverpod_twitter_course/core/providers.dart';
import 'package:riverpod_twitter_course/models/tweet_model.dart';

final tweetApiProvider = Provider((ref) {
  return TweetApi(
    db: ref.watch(appwriteDatabaseProvider),
    realtime: ref.watch(appwriteRealtimeProvider),
  );
});

abstract class ITweetApi {
  FutureEither<Document> shareTweet(Tweet tweet);
  Future<List<Document>> getTweets();
  Stream<RealtimeMessage> getLatestTweet();
  FutureEither<Document> likeTweet(Tweet tweet);
  FutureEither<Document> updateReshareCount(Tweet tweet);
  Future<List<Document>> getRepliesToTweet(Tweet tweet);
  Future<Document> getTweetById(String id);
}

class TweetApi implements ITweetApi {
  final Databases _db;
  final Realtime _realtime;
  TweetApi({required Databases db, required Realtime realtime})
      : _db = db,
        _realtime = realtime;
  @override
  FutureEither<Document> shareTweet(Tweet tweet) async {
    try {
      final document = await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.tweetCollections,
        documentId: ID.unique(),
        data: tweet.toMap(),
      );
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(e.message ?? 'some unexpected error occured', st),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  //this is function gets all the tweet from the document(in api from database table )
  @override
  Future<List<Document>> getTweets() async {
    final documents = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.tweetCollections,
        queries: [
          Query.orderDesc('tweetedAt'),
        ]);
    return documents.documents;
  }

//realtime massege from streaming
  @override
  Stream<RealtimeMessage> getLatestTweet() {
    return _realtime.subscribe([
      'databases.${AppwriteConstants.databaseId}.collections.${AppwriteConstants.tweetCollections}.documents'
    ]).stream;
  }

  @override
  FutureEither<Document> likeTweet(Tweet tweet) async {
    try {
      final document = await _db.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.tweetCollections,
        documentId: tweet.id,
        data: {'likes': tweet.likes},
      );
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(e.message ?? 'some unexpected error occured', st),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEither<Document> updateReshareCount(Tweet tweet) async {
    try {
      final document = await _db.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.tweetCollections,
        documentId: tweet.id,
        data: {'reshareCount': tweet.reshareCount},
      );
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(e.message ?? 'some unexpected error occured', st),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Future<List<Document>> getRepliesToTweet(Tweet tweet) async {
    final document = await _db.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.tweetCollections,
        queries: [
          Query.equal('repliedTo', tweet.id),
        ]);

    return document.documents;
  }

  @override
  Future<Document> getTweetById(String id) async {
    return _db.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.tweetCollections,
      documentId: id,
    );
  }
}
