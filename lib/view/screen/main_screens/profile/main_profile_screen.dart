import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/constant/colors.dart';
import 'package:foodtek/core/responseve.dart';
import 'package:foodtek/view/screen/auth/login.dart';
import 'package:foodtek/view/screen/main_screens/profile/profile_screen.dart';
import 'package:foodtek/view/screen/main_screens/profile/theme_selecter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../cubit/lang_cubit.dart';
import '../../../../cubit/theme_cubit.dart';
import '../../../widgets/main_page_widgets/language_selector_sheet.dart';
import '../../../widgets/main_page_widgets/profile_option.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final themeCubit = context.watch<ThemeCubit>();
    final currentMode = themeCubit.state;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
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
              CircleAvatar(
                //backgroundColor: AppColors.primaryColor,
                radius: 60,

                child:
                    image != null
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            File(image!.path),
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        )
                        : Image.asset(
                          "assets/images/profile/img_7.png",
                          width: 120,
                          height: 120,
                          fit: BoxFit.fill,
                        ),
              ),
              SizedBox(height: 10),
              Text(
                "Ahmad Daboor",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "ahmad1709@gmail.com",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1),
                  //     blurRadius: 6,
                  //     spreadRadius: 2,
                  //   ),
                  // ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      ProfileOption(
                        AppLocalizations.of(context)!.personal_information,
                        leading: Image.asset(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          "assets/images/profile/img.png",
                          width: responsiveHeight(context, 24),
                          height: responsiveWidth(context, 24),
                        ),
                        onTap: () {
                          // PersistentNavBarNavigator.pushNewScreen(
                          //   context,
                          //   screen: ProfileView(),
                          //   withNavBar: false,
                          //   // OPTIONAL VALUE. True by default.
                          //   pageTransitionAnimation:
                          //       PageTransitionAnimation.cupertino,
                          // );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileView(),
                            ),
                          );
                        },
                      ),
                      ProfileOption(
                        AppLocalizations.of(context)!.language,
                        trailing: Text(
                          context.read<LangCubit>().state.languageCode == 'en'
                              ? 'English'
                              : 'العربية',
                        ),
                        leading: Image.asset(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          "assets/images/profile/img_1.png",
                          width: responsiveHeight(context, 24),
                          height: responsiveWidth(context, 24),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            context: context,
                            builder: (_) => LanguageSelectorSheet(),
                          );
                        },
                      ),
                      ProfileOption(
                        "Theme",
                        leading: Image.asset(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          "assets/images/profile/dark-theme-icon.png",
                          width: responsiveHeight(context, 24),
                          height: responsiveWidth(context, 24),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (_) => ThemeSelectorScreen(),
                          );
                        },
                      ),
                      ProfileOption(
                        AppLocalizations.of(context)!.privacy_policy,
                        leading: Image.asset(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          "assets/images/profile/img_2.png",
                          width: responsiveHeight(context, 24),
                          height: responsiveWidth(context, 24),
                        ),
                        onTap: () {},
                      ),
                      ProfileOption(
                        AppLocalizations.of(context)!.setting,
                        leading: Image.asset(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          "assets/images/profile/img_3.png",
                          width: responsiveHeight(context, 24),
                          height: responsiveWidth(context, 24),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1),
                  //     blurRadius: 6,
                  //     spreadRadius: 2,
                  //   ),
                  // ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      //Push Notifications
                      ProfileOption(
                        AppLocalizations.of(context)!.push_notifications,
                        leading: Image.asset(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          "assets/images/profile/img_4.png",
                          width: responsiveHeight(context, 24),
                          height: responsiveWidth(context, 24),
                        ),
                        trailing: Switch(
                          activeTrackColor: AppColors.primaryColor,

                          value: isPushNotificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              isPushNotificationsEnabled = value;
                            });
                          },
                        ),
                        onTap: () {},
                      ),
                      //Promotional Notifications
                      ProfileOption(
                        AppLocalizations.of(context)!.promotional_notifications,
                        leading: Image.asset(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          "assets/images/profile/img_4.png",
                          width: responsiveHeight(context, 24),
                          height: responsiveWidth(context, 24),
                        ),
                        trailing: Switch(
                          activeTrackColor: AppColors.primaryColor,
                          value: isPromotionalNotificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              isPromotionalNotificationsEnabled = value;
                            });
                          },
                        ),
                        onTap: () {},
                      ),
                      // SwitchListTile(
                      //   activeTrackColor: AppColors.primaryColor,
                      //   title: Text("Push Notifications"),
                      //   value: isPushNotificationsEnabled,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       isPushNotificationsEnabled = value;
                      //     });
                      //   },
                      // ),
                      // SwitchListTile(
                      //   activeTrackColor: AppColors.primaryColor,
                      //   title: Text("Promotional Notifications"),
                      //   value: isPromotionalNotificationsEnabled,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       isPromotionalNotificationsEnabled = value;
                      //     });
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1),
                  //     blurRadius: 6,
                  //     spreadRadius: 2,
                  //   ),
                  // ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      ProfileOption(
                        AppLocalizations.of(context)!.help_center,
                        leading: Image.asset(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          "assets/images/profile/img_5.png",
                          width: responsiveHeight(context, 24),
                          height: responsiveWidth(context, 24),
                        ),
                        onTap: () {},
                      ),
                      InkWell(
                        child: ListTile(
                          leading: Image.asset(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            "assets/images/profile/img_6.png",
                            width: responsiveHeight(context, 24),
                            height: responsiveWidth(context, 24),
                          ),
                          title: Text(
                            AppLocalizations.of(context)!.log_out,
                            style: TextStyle(color: Colors.red),
                          ),
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: LoginScreen(),
                              withNavBar: false,
                              // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
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
