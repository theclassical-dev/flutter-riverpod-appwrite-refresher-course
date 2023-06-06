import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_twitter_course/common/error_page.dart';
import 'package:riverpod_twitter_course/common/loading_page.dart';
import 'package:riverpod_twitter_course/features/tweet/controller/tweet_controller.dart';
import 'package:riverpod_twitter_course/features/tweet/widgets/tweet_card.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
          data: (tweets) {
            return ListView.builder(
              itemCount: tweets.length,
              itemBuilder: (context, index) {
                final tweet = tweets[index];
                return TweetCard(tweet: tweet);
              },
            );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
