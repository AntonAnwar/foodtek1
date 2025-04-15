import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:foodtek/constant/colors.dart';
import 'package:foodtek/cubit/auth/login_cubit.dart';
import 'package:foodtek/cubit/auth/sign_up_cubit.dart';
import 'package:foodtek/view/screen/Splash_Screen.dart';
import 'package:foodtek/view/screen/onBoarding_screen.dart';
import 'cubit/auth/reset_password_cubit.dart';
import 'cubit/lang_cubit.dart';
import 'cubit/main_cubit/favorites_cubit.dart';
import 'cubit/onboarding_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

      ],
      child: BlocBuilder<LangCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en'), // English
              Locale('ar'), // arabic
            ],
            locale: locale,

            debugShowCheckedModeBanner: false,
            title: 'FoodTek',
            theme: ThemeData(
              fontFamily: 'Inter',
              colorScheme: ColorScheme.fromSeed(
                seedColor:AppColors.primaryColor,
              ),
            ),
            //home: FilterScreen(),
            home: SplashScreen(),
            //mainSplashScreen()_screens: ForgotPwScreen(),
          );
        },
      ),
    );
  }
}
