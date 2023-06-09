import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_twitter_course/features/tweet/widgets/tweet_list.dart';
import 'package:riverpod_twitter_course/theme/theme.dart';

import 'constants.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }

  static List<Widget> bottomTabBarPages = [
    const TweetList(),
    const Text('second screen'),
    const Text('third screen'),
  ];
}
