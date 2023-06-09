import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_twitter_course/theme/theme.dart';

class TweetIconButton extends StatelessWidget {
  final String pathname;
  final String text;
  final VoidCallback onTap;
  const TweetIconButton({
    Key? key,
    required this.pathname,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(children: [
        SvgPicture.asset(
          pathname,
          color: Pallete.greyColor,
        ),
        Container(
          margin: const EdgeInsets.all(6),
          child: Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        )
      ]),
    );
  }
}
