import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foodtek/constant/colors.dart';
import 'package:foodtek/cubit/auth/login_cubit.dart';
import 'package:foodtek/cubit/auth/sign_up_cubit.dart';
import 'package:foodtek/view/screen/Splash_Screen.dart';
import 'package:foodtek/view/screen/auth/login.dart';
import 'package:foodtek/view/screen/onBoarding_screen.dart';
import 'constant/theme/dark_theme.dart';
import 'constant/theme/light_theme.dart';
import 'cubit/auth/reset_password_cubit.dart';
import 'cubit/lang_cubit.dart';
import 'cubit/main_cubit/favorites_cubit.dart';
import 'cubit/onboarding_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'cubit/theme_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OnboardingCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => ResetPasswordCubit()),
        BlocProvider(create: (context) => SignUpCubit()),
        BlocProvider(create: (context) => FavoritesCubit()),
        BlocProvider(create: (context) => LangCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<LangCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'FoodTek',
                theme: lightTheme,//isDark ? ThemeData.dark : ThemeData.light
                darkTheme: dartTheme,
                themeMode: themeMode,
                locale: locale,
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                home: SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
