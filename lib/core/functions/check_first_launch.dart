import 'package:shared_preferences/shared_preferences.dart';

Future<void> checkIfFirstLaunch() async {
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;

  if (!showHome) {
    await prefs.setBool('showHome', true); // Save that onboarding was seen
  }
}
