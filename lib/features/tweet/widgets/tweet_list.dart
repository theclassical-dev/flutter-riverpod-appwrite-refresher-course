import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_twitter_course/common/error_page.dart';
import 'package:riverpod_twitter_course/common/loading_page.dart';
import 'package:riverpod_twitter_course/constants/constants.dart';
import 'package:riverpod_twitter_course/features/tweet/controller/tweet_controller.dart';
import 'package:riverpod_twitter_course/features/tweet/widgets/tweet_card.dart';
import 'package:riverpod_twitter_course/models/tweet_model.dart';

class TweetList extends ConsumerWidget {
  const TweetList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getTweetsProvider).when(
          data: (tweets) {
            return ref.watch(getLatestTweetProvider).when(
                  data: (data) {
                    if (data.events.contains(
                      'databases.*.collections.${AppwriteConstants.tweetCollections}.documents.*.create',
                    )) {
                      // print(data.events);

                      tweets.insert(0, Tweet.fromMap(data.payload));
                    }

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
                  loading: () {
                    return ListView.builder(
                      itemCount: tweets.length,
                      itemBuilder: (context, index) {
                        final tweet = tweets[index];
                        return TweetCard(tweet: tweet);
                      },
                    );
                  },
                );

            // return ListView.builder(
            //   itemCount: tweets.length,
            //   itemBuilder: (context, index) {
            //     final tweet = tweets[index];
            //     return TweetCard(tweet: tweet);
            //   },
            // );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
