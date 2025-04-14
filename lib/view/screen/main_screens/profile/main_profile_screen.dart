// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:foodtek/constant/colors.dart';
import 'package:foodtek/view/screen/main_screens/profile/profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../widgets/main_page_widgets/profile_option.dart';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({super.key});

  @override
  State<MainProfileScreen> createState() => _MainProfileScreen();
}

class _MainProfileScreen extends State<MainProfileScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  bool isPushNotificationsEnabled = true; // Track Push Notifications
  bool isPromotionalNotificationsEnabled =
      false; // Track Promotional Notifications
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: AppColors.onBoardingtextColor,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                child:
                    image != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            File(image!.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                        : Icon(Icons.person, size: 65, color: Colors.black),
              ),
              SizedBox(height: 10),
              Text(
                "Ahmad Daboor",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "ahmad1709@gmail.com",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      ProfileOption(
                        "Personal Information",
                        leading: Icon(Icons.person_add_alt_1),
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen:  ProfileView(),
                            withNavBar: false, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ProfileView(),
                          //   ),
                          // );
                        },
                      ),
                      ProfileOption(
                        "Language",
                        trailing: Text("العربية"),
                        leading: Icon(Icons.language),
                        onTap: () {},
                      ),
                      ProfileOption(
                        "Privacy Policy",
                        leading: Icon(Icons.policy_outlined),
                        onTap: () {},
                      ),
                      ProfileOption(
                        "Setting",
                        leading: Icon(Icons.settings),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      SwitchListTile(
                        activeTrackColor: AppColors.primaryColor,
                        title: Text("Push Notifications"),
                        value: isPushNotificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            isPushNotificationsEnabled = value;
                          });
                        },
                      ),
                      SwitchListTile(
                        activeTrackColor: AppColors.primaryColor,
                        title: Text("Promotional Notifications"),
                        value: isPromotionalNotificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            isPromotionalNotificationsEnabled = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      ProfileOption(
                        "Help Center",
                        leading: Icon(Icons.help_center_outlined),
                        onTap: () {},
                      ),
                      InkWell(
                        child: ListTile(
                          leading: Icon(Icons.logout, color: Colors.red),
                          title: Text(
                            "Log Out",
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
