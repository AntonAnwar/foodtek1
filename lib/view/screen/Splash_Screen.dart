// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodtek/constant/colors.dart';

import 'package:foodtek/core/functions/check_internt.dart';
import 'package:foodtek/view/screen/no_internet_screen.dart';
import 'package:foodtek/view/screen/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main_screens/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // isInternetAvailable();
    _checkIfFirstLaunch();
    super.initState();
  }

  Future<void> _checkIfFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final showHome = prefs.getBool('showHome') ?? false;

    if (!showHome) {
      await prefs.setBool('showHome', true); // Save that onboarding was seen
    }

    Future.delayed(const Duration(seconds: 3), () async {
      bool isconected = await isInternetAvailable();
      if (isconected) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            //builder: (context) => OnboardingScreen(),
            builder: (context) => showHome ? MainPage() : OnboardingScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            //builder: (context) => OnboardingScreen(),
            builder: (context) => NoInternetScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background color
          Container(color: AppColors.primaryColor),
          Positioned.fill(
            child: Image.asset(
              "assets/images/pattern.png",

              fit: BoxFit.cover,
              // Ensures the image covers the entire screen
              color: const Color.fromARGB(255, 26, 92, 45),
              // Adjust opacity for transparency
              colorBlendMode:
                  BlendMode.modulate, // Blends color with background
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/foodtek-logo.png",
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
