// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:foodtek/core/functions/check_internt.dart';
import 'package:foodtek/view/screen/auth/login.dart';
import 'package:foodtek/view/screen/onboarding_screen.dart';
import 'package:foodtek/view/widgets/auth/foodtek_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool? showHome;

  @override
  void initState() {
    checkIfFirstLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 100, color: Colors.grey),
              SizedBox(height: 20),
              Text('No Internet Connection', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20),
              FoodtekButton(
                onPressed: () async {
                  bool isconected = await isInternetAvailable();
                  if (isconected == true) {
                    // إعادة توجيه المستخدم للصفحة الرئيسية إذا عاد الاتصال
                    if (showHome!) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    } else {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => OnboardingScreen(),
                        ),
                      );
                    }

                    setState(() {});
                  }
                },
                text: "Try again",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkIfFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    showHome = prefs.getBool('showHome') ?? false;

    if (!showHome!) {
      await prefs.setBool('showHome', true); // Save that onboarding was seen
    }
  }
}
