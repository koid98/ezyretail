import 'package:ezyretail/pages/login_screen.dart';
import 'package:ezyretail/themes/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    initFunction();
  }

  Future<void> initFunction() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: ColorHelper.myDefaultBackColor,
            child: Center(
              child: SizedBox(
                  width: 30.w,
                  child: Stack(
                    children: [
                      Image.asset("assets/images/ezypos_logo.png"),
                      Shimmer.fromColors(
                        baseColor: Colors.white.withOpacity(0.01),
                        highlightColor: Colors.white.withOpacity(0.8),
                        period: const Duration(seconds: 3),
                        child: Image.asset(
                          "assets/images/ezypos_logo.png",
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Positioned(
            bottom: 20, // Distance from the bottom
            left: 0,
            right: 0, // To center horizontally
            child: GestureDetector(
              onLongPress: () {
                // callDealerSettings();
              },
              child: Image.asset(
                'assets/icons/ezy_solutions.png',
                height: 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
