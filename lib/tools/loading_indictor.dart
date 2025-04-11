import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

import '../../themes/color_helper.dart';

class LoadingIndicator extends StatefulWidget {
  final String message;
  const LoadingIndicator({super.key, this.message = "Loading"});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Image.asset("assets/images/icon.png", height: 100),
                Shimmer.fromColors(
                  baseColor: Colors.white.withOpacity(0.01),
                  highlightColor: Colors.white.withOpacity(0.5),
                  period: const Duration(seconds: 3),
                  direction: ShimmerDirection.ltr,
                  child: Image.asset("assets/images/icon.png", height: 100),
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.message,
                  style: const TextStyle(
                    color: ColorHelper.myWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    WavyAnimatedText(
                      '.....',
                      textStyle: const TextStyle(
                        color: ColorHelper.myWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                  isRepeatingAnimation: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
