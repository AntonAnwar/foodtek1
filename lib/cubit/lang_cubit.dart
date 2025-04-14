import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangCubit extends Cubit<Locale> {
  LangCubit() : super(const Locale("en")) {
    getLang();
  }

  Future<void> changeLang(String langCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', langCode);
    emit(Locale(langCode));
  }

  Future<void> getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String langCode = prefs.getString("lang") ?? "en";
    emit(Locale(langCode));
  }
}
