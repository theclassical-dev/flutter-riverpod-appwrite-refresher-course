import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_twitter_course/constants/constants.dart';
import 'package:riverpod_twitter_course/core/core.dart';
import 'package:riverpod_twitter_course/core/providers.dart';
import 'package:riverpod_twitter_course/models/tweet_model.dart';

final tweetApiProvider = Provider((ref) {
  return TweetApi(db: ref.watch(appwriteDatabaseProvider));
});

abstract class ITweetApi {
  FutureEither<Document> shareTweet(Tweet tweet);
}

class TweetApi implements ITweetApi {
  final Databases _db;
  TweetApi({required Databases db}) : _db = db;
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
}
