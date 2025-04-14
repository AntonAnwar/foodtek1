// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../constant/colors.dart';

class PromoBanner extends StatefulWidget {
  const PromoBanner({super.key});

  @override
  State<PromoBanner> createState() => _PromoBannerState();
}

class _PromoBannerState extends State<PromoBanner> {
  final List<String> images = [
    // the images being displayed
    'assets/images/mainPage/home_page_images/recommend_images/sushi.png',
    'assets/images/mainPage/home_page_images/recommend_images/curry.png',
    'assets/images/mainPage/home_page_images/recommend_images/sushi.png',
    'assets/images/mainPage/home_page_images/recommend_images/sushi.png',
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
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
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
                          0.9, // Adjust width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Text Container on the right
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(.9),
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(15),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Experience our delicious new dish",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    "30% OFF",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Image on the left
                          ClipRRect(
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(15),
                            ),
                            child: Image.asset(
                              image,
                              width:
                                  MediaQuery.of(context).size.width *
                                  0.5, // Half screen width
                              height: 180,
                              fit: BoxFit.cover,
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
