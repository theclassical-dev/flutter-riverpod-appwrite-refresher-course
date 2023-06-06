import 'package:flutter/material.dart';
import 'package:riverpod_twitter_course/theme/theme.dart';

class HashtagText extends StatelessWidget {
  final String text;
  const HashtagText({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];
    text.split(' ').forEach(
      ((element) {
        if (element.startsWith('#')) {
          textSpans.add(
            TextSpan(
              text: '$element ',
              style: const TextStyle(
                  color: Pallete.blueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else if (element.startsWith('www. ') ||
            element.startsWith('https://') ||
            element.startsWith('http://')) {
          textSpans.add(
            TextSpan(
              text: '$element ',
              style: const TextStyle(
                color: Pallete.blueColor,
                fontSize: 18,
              ),
            ),
          );
        } else {
          textSpans.add(
            TextSpan(
              text: '$element ',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          );
        }
      }),
    );
    return RichText(
      text: TextSpan(children: textSpans),
    );
  }
}
