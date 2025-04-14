// ignore_for_file: avoid_print

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

Future<bool> isInternetAvailable() async {
  bool isConnected = await InternetConnection().hasInternetAccess;

  if (isConnected) {
    print("✅ الإنترنت متصل فعليًا");
  } else {
    print("❌ لا يوجد اتصال بالإنترنت");
  }

  return isConnected;
}
