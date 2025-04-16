// ignore_for_file: deprecated_member_use
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/core/responseve.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../constant/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../cubit/lang_cubit.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final List<String> images = [
    // the images being displayed
    'assets/images/mainPage/img_1.png',
    'assets/images/mainPage/img_1.png',
    'assets/images/mainPage/img_1.png',
  ];

  int currentIndex = 0; // Track current index
  final CarouselSliderController _carouselController =
      CarouselSliderController(); // Carousel Controller

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          carouselController: _carouselController, // Attach the controller
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.2,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.94,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index; // Update the selected index
              });
            },
          ),
          items:
              images.map((image) {
                // the items (the images)
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width:
                          MediaQuery.of(context).size.width *
                          .95, // Adjust width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child:
                          context.read<LangCubit>().state.languageCode == "en"
                              ? Row(
                                children: [
                                  Expanded(
                                    child: Stack(

                                      children: [
                                        // Promo text container (same as before)
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: 7,
                                            top: 26,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor
                                                .withOpacity(.9),
                                            borderRadius:
                                                const BorderRadius.horizontal(
                                                  left: Radius.circular(10),
                                                ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.offerDes,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "30% ${AppLocalizations.of(context)!.off}",
                                                textAlign: TextAlign.start,

                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Top left decorative arc
                                        Positioned(
                                          top: -16,
                                          right: 15,
                                          child: Image.asset(
                                            'assets/images/mainPage/img_2.png',
                                            // replace with actual path
                                            width: responsiveWidth(context, 55),
                                            height: responsiveHeight(
                                              context,
                                              55,
                                            ),
                                          ),
                                        ),

                                        // Bottom left decorative arc
                                        Positioned(
                                          bottom: -15,
                                          left: 0,
                                          child: Image.asset(
                                            'assets/images/mainPage/img_3.png',
                                            // replace with actual path
                                            width: responsiveWidth(context, 46),
                                            height: responsiveHeight(
                                              context,
                                              46,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  ClipRRect(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(10),
                                    ),
                                    child: Image.asset(
                                      image,
                                      width: responsiveWidth(context, 211),
                                      // MediaQuery.of(context).size.width *
                                      // 0.5, // Half screen width
                                      height: responsiveHeight(context, 200),
                                      // MediaQuery.of(context).size.height *
                                      //     0.2,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              )
                              : Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(10),
                                    ),
                                    child: Image.asset(
                                      image,
                                      width: responsiveWidth(context, 211),
                                      // MediaQuery.of(context).size.width *
                                      // 0.5, // Half screen width
                                      height: responsiveHeight(context, 200),
                                      // MediaQuery.of(context).size.height *
                                      //     0.2,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  Expanded(
                                    child: Stack(
                                      children: [
                                        // Promo text container (same as before)
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: 7,
                                            top: 26,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor
                                                .withOpacity(.9),
                                            borderRadius:
                                                const BorderRadius.horizontal(
                                                  left: Radius.circular(10),
                                                ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(
                                                  context,
                                                )!.offerDes,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                "30% ${AppLocalizations.of(context)!.off}",
                                                textAlign: TextAlign.start,

                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Top left decorative arc
                                        Positioned(
                                          top: -16,
                                          right: 15,
                                          child: Image.asset(
                                            'assets/images/mainPage/img_2.png',
                                            // replace with actual path
                                            width: responsiveWidth(context, 55),
                                            height: responsiveHeight(
                                              context,
                                              55,
                                            ),
                                          ),
                                        ),

                                        // Bottom left decorative arc
                                        Positioned(
                                          bottom: -15,
                                          left: 0,
                                          child: Image.asset(
                                            'assets/images/mainPage/img_3.png',
                                            // replace with actual path
                                            width: responsiveWidth(context, 46),
                                            height: responsiveHeight(
                                              context,
                                              46,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                    );
                  },
                );
              }).toList(),
        ),
        const SizedBox(height: 10),
        Center(
          // the Indicator
          child: AnimatedSmoothIndicator(
            activeIndex: currentIndex, // Use the tracked index
            count: images.length,
            effect: ExpandingDotsEffect(
              dotWidth: 10,
              dotHeight: 10,
              spacing: 16,
              dotColor: Colors.black12,
              activeDotColor: AppColors.primaryColor,
            ),
            onDotClicked: (index) {
              _carouselController.animateToPage(
                index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ],
    );
  }
}
