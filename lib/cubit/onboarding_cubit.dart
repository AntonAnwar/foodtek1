// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../state/onboarding_cubit_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  //from chatGPT
  OnboardingCubit() : super(OnboardingInitial());

  final int totalPages = 4;

  void updatePage(int index) {
    bool isLast = index == totalPages - 1; // Last page check
    emit(OnboardingPageChanged(index, isLast));
  }

  /// Saves onboarding completion state when the user presses a button
  Future<void> completeOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('showHome', true);
    emit(OnboardingCompleted());
  }

  Future<Position> locationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<bool> isInternetAvailable() async {
    bool isConnected = await InternetConnection().hasInternetAccess;

    if (isConnected) {
      print("✅ الإنترنت متصل فعليًا");
    } else {
      print("❌ لا يوجد اتصال بالإنترنت");
      emit(InternetCheckOffState());
    }

    return isConnected;
  }
}
