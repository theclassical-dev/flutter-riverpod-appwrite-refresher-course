import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_twitter_course/apis/tweet_api.dart';
import 'package:riverpod_twitter_course/core/enums/tweet_type_enums.dart';
import 'package:riverpod_twitter_course/core/utlis.dart';
import 'package:riverpod_twitter_course/features/auth/controller/auth_controller.dart';
import 'package:riverpod_twitter_course/models/tweet_model.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetController, bool>((ref) {
  return TweetController(ref: ref, tweetApi: ref.watch(tweetApiProvider));
});

class TweetController extends StateNotifier<bool> {
  final TweetApi _tweetApi;
  final Ref _ref;
  TweetController({required Ref ref, required TweetApi tweetApi})
      : _ref = ref,
        _tweetApi = tweetApi,
        super(false);

  void shareTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, 'Please enter text');
      return;
    }

    if (images.isNotEmpty) {
      _shareImageTweet(
        images: images,
        text: text,
        context: context,
      );
    } else {
      _shareTextTweet(
        text: text,
        context: context,
      );
    }
  }

  void _shareImageTweet({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {}

  void _shareTextTweet({
    required String text,
    required BuildContext context,
  }) async {
    state = true;
    final hashtags = _getHashtagsFromText(text);
    String link = _getLinkFromText(text);
    //prrovider that supply the logged in user id
    final user = _ref.read(currentUserDetailsProvider).value!;
    Tweet tweet = Tweet(
      text: text,
      hashtags: hashtags,
      link: link,
      imageLinks: const [],
      uid: user.uid,
      tweetType: TweetType.text,
      tweetedAt: DateTime.now(),
      likes: const [],
      commentIds: const [],
      id: '',
      reshareCount: 0,
    );
    state = false;
    final res = await _tweetApi.shareTweet(tweet);
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  //get link from text

  String _getLinkFromText(String text) {
    //Peter Pan LinkedIn www.linkedin.com
    //['peter','pan', 'www.linkedin']

    String link = '';
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('https://') ||
          word.startsWith('http://') ||
          word.startsWith('www.')) {
        link = word;
      }
    }
    return link;
  }

  List<String> _getHashtagsFromText(String text) {
    List<String> hashtags = [];
    List<String> wordsInSentence = text.split(' ');
    for (String word in wordsInSentence) {
      if (word.startsWith('#')) {
        hashtags.add(word);
      }
    }
    return hashtags;
  }
}