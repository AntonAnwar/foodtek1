import 'package:flutter/material.dart';
import 'package:foodtek/constant/colors.dart';

import '../../../core/responseve.dart';

class OnboardingWidget extends StatelessWidget {
  final String title,
      description,
      stackImage,
      onBoardingImg,
      firstButtonText,
      secondButtonText;
  final VoidCallback onPressedOne, onPressedTwo;
  final bool isVisible;
  final double imageheight, imageWiddth, top;

  const OnboardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.firstButtonText,
    required this.secondButtonText,
    required this.onPressedOne,
    required this.onPressedTwo,
    required this.isVisible,
    required this.imageheight,
    required this.imageWiddth,
    required this.top,
    required this.stackImage,
    required this.onBoardingImg,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        // stack headre images
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(height: responsiveHeight(context, 450)),
            Image.asset(
              stackImage,

              height: 290,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.cover,
              // Ensures the image covers the entire screen
              color: Color.fromARGB(255, 255, 255, 255),
              colorBlendMode:
                  BlendMode.modulate, // Blends color with background
            ),

            Positioned(
              top: top,
              child: Image.asset(
                onBoardingImg,

                height: responsiveHeight(context, imageheight),
                width: responsiveWidth(context, imageWiddth),
              ),
            ),
          ],
        ),

        const SizedBox(height: 30),

        // title text
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.onBoardingtextColor,

            fontSize: 30,
            fontWeight: FontWeight.bold,
            // letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 15),

        // sub title text
        SizedBox(
          height: responsiveHeight(context, 100),
          child: Text(
            description,
            textAlign: TextAlign.center,
            softWrap: true,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.onBoardingtextColor,
              height: 1.5,
            ),
          ),
        ),

        SizedBox(height: responsiveHeight(context, 30)),

        // button one
        Container(
          width: responsiveWidth(context, 307),
          height: responsiveHeight(context, 58),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor, AppColors.secondaryColor],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ElevatedButton(
            onPressed: onPressedOne,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              // Keep button transparent
              shadowColor: Colors.transparent,
              // Remove shadow
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
            child: Text(
              firstButtonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 15),

        // button two
        Visibility(
          visible: isVisible,
          child: SizedBox(
            width: responsiveWidth(context, 307),
            height: responsiveHeight(context, 58),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 194, 194, 194),
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 14),
              ),
              onPressed: onPressedTwo,
              child: Text(
                secondButtonText,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
