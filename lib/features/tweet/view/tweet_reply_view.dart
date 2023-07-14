import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_twitter_course/features/tweet/controller/tweet_controller.dart';
import 'package:riverpod_twitter_course/features/tweet/widgets/tweet_card.dart';
import 'package:riverpod_twitter_course/models/tweet_model.dart';

class TweetReplyScreen extends ConsumerWidget {
  static route(Tweet tweet) => MaterialPageRoute(
        builder: ((context) => TweetReplyScreen(
              tweet: tweet,
            )),
      );

  final Tweet tweet;
  const TweetReplyScreen({super.key, required this.tweet});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweet'),
      ),
      body: Column(
        children: [
          TweetCard(tweet: tweet),
        ],
      ),
      bottomNavigationBar: TextField(
        onSubmitted: (value) {
          ref.read(tweetControllerProvider.notifier).shareTweet(
              images: [], text: value, context: context, repliedTo: tweet.id);
        },
        decoration: const InputDecoration(hintText: 'Tweet your reply'),
      ),
    );
  }
}
