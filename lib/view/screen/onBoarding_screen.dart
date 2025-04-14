import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/constant/colors.dart';
import 'package:foodtek/constant/onboarding_data.dart';

import 'package:foodtek/core/functions/determine_position.dart';
import 'package:foodtek/cubit/onboarding_cubit.dart';
import 'package:foodtek/state/onboarding_cubit_state.dart';
import 'package:foodtek/view/screen/auth/login.dart';
import 'package:foodtek/view/widgets/onboarding/onBoarding_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // one time OnBoarding screen
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          // ignore: unused_local_variable
          int currentPage = 0;
          bool isLastPage = false;

          if (state is OnboardingPageChanged) {
            currentPage = state.currentPage;
            isLastPage = state.isLastPage;
          }

          return PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              context.read<OnboardingCubit>().updatePage(index);
            },
            itemCount: 4,
            itemBuilder: (context, index) {
              return OnboardingWidget(
                stackImage: stackImages[index],
                onBoardingImg: onboardingImages[index],
                top: topPositions[index],
                imageWiddth: imageWidths[index],
                imageheight: imageHeights[index],
                title: onboardingTitles[index],
                description: onboardingDescriptions[index],
                firstButtonText: firstButtonTexts[index],
                onPressedOne: () async {
                  if (isLastPage) {
                    context.read<OnboardingCubit>().completeOnboarding();
                    determinePosition().then(
                      // calles the method to git the location and then it goes to the login screen
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      ),
                    );
                    // Future.delayed(const Duration(seconds: 3), () {
                    //   // so it navigates to the login screen
                    //
                    // });
                  } else {
                    // else it continues to the next screen
                    pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                secondButtonText: secondButtonTexts[index],
                onPressedTwo: () {
                  LocationPermission.denied; // does not get the location
                  context.read<OnboardingCubit>().completeOnboarding();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                isVisible: isLastPage,
              );
            },
          );
        },
      ),

      bottomSheet: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          bool isLastPage =
              (state is OnboardingPageChanged) ? state.isLastPage : false;
          return isLastPage // if its the last page remove the bottom sheet
              ? SizedBox()
              : Container(
                height: 60,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.read<OnboardingCubit>().completeOnboarding();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Center(
                      // the three dots in the middle
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: WormEffect(
                          dotWidth: 10,
                          dotHeight: 10,
                          spacing: 16,
                          dotColor: Colors.black12,
                          activeDotColor: AppColors.primaryColor,
                        ),
                        onDotClicked: (index) {
                          pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                      ),
                    ),
                    IconButton(
                      // to move on page at a time
                      onPressed: () {
                        pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              );
        },
      ),
    );
  }
}
