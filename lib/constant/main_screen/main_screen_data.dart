// main screen data
import 'package:flutter/material.dart';
import '../../view/screen/main_screens/cart/main_cart_screen.dart';
import '../../view/screen/main_screens/favorites/favorites_screen.dart';
import '../../view/screen/main_screens/cart/history_screen.dart';
import '../../view/screen/main_screens/history/delivery_tracking_screen.dart';
import '../../view/screen/main_screens/history/order_details_page.dart';
import '../../view/screen/main_screens/home/home_screen.dart';
import '../../view/screen/main_screens/profile/main_profile_screen.dart';

final List<String> bottomNavLabels = [
  "Home",
  "Favorites",
  "",
  "Track",
  "Profile",
];
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
  //HistoryScreen(locationBar: true),
  const MainProfileScreen(),
];
