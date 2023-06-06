import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_twitter_course/common/common.dart';
import 'package:riverpod_twitter_course/core/enums/tweet_type_enums.dart';
import 'package:riverpod_twitter_course/features/auth/controller/auth_controller.dart';
import 'package:riverpod_twitter_course/features/tweet/widgets/carousel_image.dart';
import 'package:riverpod_twitter_course/features/tweet/widgets/hashtag_text.dart';
import 'package:riverpod_twitter_course/models/tweet_model.dart';
import 'package:riverpod_twitter_course/theme/theme.dart';
import 'package:timeago/timeago.dart' as timeago;

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({required this.tweet, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userDetailsProvider(tweet.uid)).when(
          data: (user) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.profilePic),
                        radius: 25,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //retweeted
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 5),
                                child: Text(
                                  user.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19),
                                ),
                              ),
                              Text(
                                '@${user.name} . ${timeago.format(
                                  tweet.tweetedAt,
                                  locale: 'en_short',
                                )}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Pallete.greyColor,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          //replied to
                          HashtagText(text: tweet.text),
                          if (tweet.tweetType == TweetType.image)
                            CarouselImage(imageLinks: tweet.imageLinks),
                          if (tweet.link.isNotEmpty) ...[
                            const SizedBox(
                              height: 4,
                            ),
                            AnyLinkPreview(
                                displayDirection:
                                    UIDirection.uiDirectionHorizontal,
                                link: 'https://${tweet.link}'),
                          ]
                        ],
                      ),
                    )
                  ],
                ),
              ],
            );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Loader(),
        );
  }
}
