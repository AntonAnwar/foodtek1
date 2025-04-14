import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../constant/colors.dart';
import '../../../../cubit/main_cubit/favorites_cubit.dart';
import '../../../../core/responseve.dart';
import '../../../widgets/main_page_widgets/location_notification_srearch.dart';
import '../home/item_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LocationNotificationSrearch(showSearchBar: true),
          const SizedBox(height: 10),

          Expanded(
            child: BlocBuilder<FavoritesCubit, FavoritesState>(
              builder: (context, state) {
                if (state is FavoritesLoaded) {

                  if (state.favorites.isEmpty) {
                    return Center(child: Text("No favorites yet!"));
                  }
                  return GridView.builder(
                    padding:const EdgeInsets.only(
                      top: 30,
                      bottom: 60, // Add bottom padding to avoid bottom bar!
                      left: 10,
                      right: 10,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 60,
                        ),
                    itemCount: state.favorites.length,
                    itemBuilder: (context, index) {
                      final item = state.favorites[index];

                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Card(
                            //color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 45,
                                bottom: 35,
                                left: 10,
                                right: 10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    item.description,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    '${item.price}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Top Image (half in, half out)
                          Positioned(
                            top: -30,
                            left: 30,
                            right: 30,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(
                                'assets/images/mainPage/home_page_images/img.png',
                              ),
                              backgroundColor: Colors.grey,
                              child: Image.asset(
                                item.image,
                                height: responsiveHeight(context, 74),
                                width: responsiveWidth(context, 74),
                              ),
                            ),
                          ),

                          // Heart Icon
                          Positioned(
                            top: -10,
                            right: -10,
                            child: CircleAvatar(
                              backgroundColor: Colors.green.shade100,
                              child: IconButton(
                                icon: Icon(Icons.favorite, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder:
                                        (context) => BackdropFilter(
                                          filter: ImageFilter.blur(
                                            sigmaX: 5,
                                            sigmaY: 5,
                                          ),
                                          // Adds background blur
                                          child: AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            // Keeps background clear
                                            contentPadding: EdgeInsets.zero,
                                            insetPadding: EdgeInsets.all(10),
                                            // Controls overall padding
                                            content: Container(
                                              padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    'Are you sure you want to remove it from favorites?',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                            FavoritesCubit
                                                          >()
                                                          .toggleFavorite(item);
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          AppColors
                                                              .primaryColor,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                      ),
                                                      minimumSize: Size(
                                                        double.infinity,
                                                        50,
                                                      ), // Full-width button
                                                    ),
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                  );
                                },
                              ),
                            ),
                          ),

                          // Bottom Button (half in, half out)
                          Positioned(
                            bottom: -15,
                            left: 20,
                            right: 20,
                            child: SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen:  ItemDetailsScreen(
                                      name: item.name,
                                      image: item.image,
                                      price: item.price,
                                      description: item.description,
                                      rating: item.rating,
                                      id: item.id,
                                    ),
                                    withNavBar: false, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder:
                                  //         (context) => ItemDetailsScreen(
                                  //           name: item.name,
                                  //           image: item.image,
                                  //           price: item.price,
                                  //           description: item.description,
                                  //           rating: item.rating,
                                  //           id: item.id,
                                  //         ),
                                  //   ),
                                  // );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  "Order Now",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );

                }
                return Center(
                  child: CircularProgressIndicator(),
                ); // Handle other states
              },
            ),
          ),
        ],

      ),
    );
  }
}
