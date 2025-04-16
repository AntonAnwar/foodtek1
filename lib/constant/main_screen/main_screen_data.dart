// main screen data
// the screens in the bottom sheet and there data
import 'package:flutter/material.dart';
import '../../view/screen/main_screens/cart/main_cart_screen.dart';
import '../../view/screen/main_screens/favorites/favorites_screen.dart';
import '../../view/screen/main_screens/history/order_details_page.dart';
import '../../view/screen/main_screens/home/home_screen.dart';
import '../../view/screen/main_screens/profile/main_profile_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// final List<String> bottomNavLabels = [
//   "Home",
//   "Favorites",
//   "",
//   "Track",
//   "Profile",
// ];
//*************///********////
List<String> getBottomNavLabels(BuildContext context) {
  return [
    AppLocalizations.of(context)!.home,
    AppLocalizations.of(context)!.favorite,
    "",
    AppLocalizations.of(context)!.track,
    AppLocalizations.of(context)!.profile,
  ];
}
//************///**/******///
final List<String> bottomNavImages = [
  "assets/images/mainPage/home.png",
  "assets/images/mainPage/Favorites.png",
  "assets/images/mainPage/cart.png",
  "assets/images/mainPage/Track.png",
  "assets/images/mainPage/profile.png",
];
final List<Widget> pages = [
  const HomeScreen(),
  FavoritesScreen(),
  const MainCartPage(),
  OrderDetailsPage(),
  const MainProfileScreen(),
];
