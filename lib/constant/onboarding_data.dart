import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// قائمة العناوين
List<String> getOnboardingTitles(BuildContext context) {
  return [
    AppLocalizations.of(context)!.onboardring1_title,
    AppLocalizations.of(context)!.onboardring2_title,
    AppLocalizations.of(context)!.onboardring3_title,
    AppLocalizations.of(context)!.onboardring4_title,
  ];
}
// final List<String> onboardingTitles = [
//   "Welcome To Foodtek",
//   "Get Delivery On Time",
//   "Choose Your Food",
//   "Turn On Your Location",
// ];

// قائمة الأوصاف
List<String> getOnboardingDescriptions(BuildContext context) => [
  AppLocalizations.of(context)!.onboardring1_des,
  AppLocalizations.of(context)!.onboardring2_des,
  AppLocalizations.of(context)!.onboardring3_des,
  AppLocalizations.of(context)!.onboardring4_des,
];
// قائمة الأوصاف
// final List<String> onboardingDescriptions = [
//   "Enjoy A Fast And Smooth Food Delivery\n At Your Doorstep",
//   "Order Your Favorite Food Within The \n Plam Of Your Hand And The Zone \n Of Your Comfort",
//   "Order Your Favorite Food Within The \n Plam Of Your Hand And The Zone \n OF Your Comfort",
//   "To Continues, Let Your Device Turn \n On Location, Which Uses Google's\n Location Service",
// ];

// قائمة صور النمط (الخلفية)
final List<String> stackImages = [
  "assets/images/pattern.png",
  "assets/images/pattern.png",
  "assets/images/pattern.png",
  "assets/images/onboarding/maps.png",
];

// قائمة صور التعريف الأساسية
final List<String> onboardingImages = [
  "assets/images/onboarding/order-food-pana.png",
  "assets/images/onboarding/take-away-cuate.png",
  "assets/images/onboarding/take-away-cuate.png",
  "assets/images/onboarding/take-away-cuate.png",
];

// قائمة قيم الـ top
final List<double> topPositions = [100, 150, 150, 150];

// قائمة عرض الصور
final List<double> imageWidths = [328, 328.5, 328.5, 328.5];

// قائمة ارتفاع الصور
final List<double> imageHeights = [328, 319, 319, 319];

// قائمة نصوص الزر الأول
// final List<String> firstButtonTexts = [
//   'Continue',
//   'Continue',
//   'Continue',
//   'Yes, Turn It On',
// ];
List<String> getFirstButtonTexts(BuildContext context) => [
  AppLocalizations.of(context)!.continu,
  AppLocalizations.of(context)!.continu,
  AppLocalizations.of(context)!.continu,
  AppLocalizations.of(context)!.yes_turn_it_on,
];
// قائمة نصوص الزر الثاني
//final List<String> secondButtonTexts = ['', '', '', 'Cancel'];

List<String> getSecondButtonTexts(BuildContext context) => [
  '',
  '',
  '',
  AppLocalizations.of(context)!.cancel,
];
