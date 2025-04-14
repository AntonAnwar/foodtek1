import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubit/main_cubit/favorites_cubit.dart';
import '../../../widgets/auth/foodtek_button.dart';
import '../../../widgets/main_page_widgets/location_notification_srearch.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodtek/constant/colors.dart';

class ItemDetailsScreen extends StatefulWidget {
  final String name;
  final String image;
  final String price;
  final String description;
  final double rating;
  final int id;

  const ItemDetailsScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.rating,
    required this.id,
  }) : super(key: key);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  bool isFav = false;
  int qty = 0;
  late double currentRating; // Create a separate variable for rating

  double minSpicy = 0;
  double maxSpicy = 10;
  double spicy = 0;

  @override
  void initState() {
    super.initState();
    currentRating = widget.rating; // Initialize with the passed rating
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            LocationNotificationSrearch(showSearchBar: true),
            SizedBox(height: 15),

            // Image
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Image.asset(widget.image, fit: BoxFit.contain),
            ),

            // Item Name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                  ),
              // BlocBuilder<FavoritesCubit, FavoritesState>(
              //   builder: (context, state) {
              //     final favCubit = context.read<FavoritesCubit>();
              //
              //     final favoriteItem = FavoriteItem(
              //       id: widget.id,
              //       name: widget.name,
              //       image: widget.image,
              //       price: widget.price,
              //       description: widget.description,
              //       rating: widget.rating,
              //     );
              //
              //     final isFav = favCubit.isFavorite(favoriteItem);
              //
              //     return IconButton(
              //       icon: Icon(
              //         isFav ? Icons.favorite : Icons.favorite_border,
              //         color: Colors.red,
              //       ),
              //       onPressed: () {
              //         favCubit.toggleFavorite(favoriteItem);
              //       },
              //     );
              //   },
              // )

              ],
              ),
            ),

            // Rating Bar (Now Updateable)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  RatingBar.builder(
                    initialRating: currentRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30,
                    itemBuilder:
                        (context, _) =>
                            Icon(Icons.star, color: Colors.yellowAccent),
                    onRatingUpdate: (newRating) {
                      setState(() {
                        currentRating =
                            newRating; // Update local state variable
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  Text(
                    "${currentRating.toStringAsFixed(1)}",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            // Price
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                " ${widget.price}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 30),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(widget.description, style: TextStyle(fontSize: 12)),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Spicy Selector
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Spicy"),
                      Row(
                        children: [
                          const Text("Mild", style: TextStyle(color: Colors.green)),
                          SizedBox(
                            width: 150, // Adjust width as needed
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 6,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
                              ),
                              child: Slider(
                                value: spicy,
                                min: minSpicy,
                                max: maxSpicy,
                                //divisions: 9,
                                activeColor: Colors.red,
                                inactiveColor: Colors.grey[300],
                                onChanged: (value) {
                                  setState(() {
                                    spicy = value;
                                    qty = value.round();
                                  });
                                },
                              ),
                            ),
                          ),
                          const Text("Hot", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ],
                  ),

                  // Quantity Selector
                  Column(
                    children: [
                      const Text("Quantity"),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (qty > minSpicy.toInt()) {
                                setState(() {
                                  qty--;
                                  spicy = qty.toDouble();
                                 // spicy -= (maxSpicy - minSpicy) / 9;
                                });
                              }
                            },
                            icon: const Icon(Icons.remove),
                            color: Colors.green,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.green),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            qty.toString(),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5,),
                          IconButton(
                            onPressed: () {
                              if (qty < maxSpicy.toInt()) {
                                setState(() {
                                  qty++;
                                  spicy = qty.toDouble();
                                  //spicy += (maxSpicy - minSpicy) / 9;
                                });
                              }
                            },
                            icon: const Icon(Icons.add, color: Colors.white),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            // Add to Cart Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
              child: FoodtekButton(
                text: "Add to Cart",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
