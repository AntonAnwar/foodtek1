import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/constant/colors.dart';

import '../../../../cubit/lang_cubit.dart';
import '../../../widgets/main_page_widgets/location_notification_srearch.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends State<FilterScreen> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();

    selectedCategory = "All";
  }

  final double _minPrice = 0;
  final double _maxPrice = 108;
  double _price = 0;
  final double _minDiscount = 0;
  final double _maxDiscount = 50;

  double _discount = 25;
  int _selectedLocation = 0;
  final Set<String> _selectedDishes = {}; // Track selected dishes

  // List<String> categories = ["Fast Food", "Sea Food", "Dessert"];
  List<bool> categorySelected = [false, false, false];

  List<String> locationOptions = ["1 KM", "5 KM", "10 KM"];

  List<bool> dishesSelected = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    //selectedCategory = AppLocalizations.of(context)!.all;

    List<Map<String, String>> dishes = [
      {
        "name": AppLocalizations.of(context)!.cheeseburger,
        "category": AppLocalizations.of(context)!.fast_food,
      },
      {
        "name": AppLocalizations.of(context)!.chocolate_cake,
        "category": AppLocalizations.of(context)!.dessert,
      },
      {
        "name": AppLocalizations.of(context)!.spicy_crab_cakes,
        "category": AppLocalizations.of(context)!.sea_food,
      },
      {
        "name": AppLocalizations.of(context)!.miso_glazed_cod,
        "category": AppLocalizations.of(context)!.sea_food,
      },
      {
        "name": AppLocalizations.of(context)!.lobster_thermidor,
        "category": AppLocalizations.of(context)!.sea_food,
      },
      {
        "name": AppLocalizations.of(context)!.seafood_paella,
        "category": AppLocalizations.of(context)!.sea_food,
      },
      {
        "name": AppLocalizations.of(context)!.tuna_tartare,
        "category": AppLocalizations.of(context)!.sea_food,
      },
      {
        "name": AppLocalizations.of(context)!.clam_chowder,
        "category": AppLocalizations.of(context)!.sea_food,
      },
    ];

    List<String> categories = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.fast_food,
      AppLocalizations.of(context)!.sea_food,
      AppLocalizations.of(context)!.dessert,
    ];

    List<Map<String, String>> getFilteredDishes() {
      if (selectedCategory == AppLocalizations.of(context)!.all) {
        return dishes;
      } else {
        return dishes
            .where((dish) => dish["category"] == selectedCategory)
            .toList();
      }
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      //appBar: AppBar(title: Text("Filter"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocationNotificationSrearch(showSearchBar: false),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    AppLocalizations.of(context)!.filter,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  // Price Range
                  SizedBox(height: height * .02),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.18,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Align(
                            alignment:
                                context.read<LangCubit>().state.languageCode ==
                                        "en"
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            child: Text(
                              AppLocalizations.of(context)!.min,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: height * 0.06,
                          width: width * 0.18,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Align(
                            alignment:
                                context.read<LangCubit>().state.languageCode ==
                                        "en"
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            child: Text(
                              AppLocalizations.of(context)!.max,
                              //textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$${_minPrice.toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            "\$${_maxPrice.toStringAsFixed(0)}",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Slider(
                              activeColor: Colors.green,
                              value: _price,
                              min: _minPrice,
                              max: _maxPrice,
                              divisions: 108,
                              label: "\$${_price.toStringAsFixed(0)}",
                              onChanged: (value) {
                                setState(() {
                                  _price = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Discount
                  SizedBox(height: height * .02),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.height * 0.18,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Align(
                            alignment:
                                context.read<LangCubit>().state.languageCode ==
                                        "en"
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            child: Text(
                              AppLocalizations.of(context)!.min,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.height * 0.18,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Align(
                            alignment:
                                context.read<LangCubit>().state.languageCode ==
                                        "en"
                                    ? Alignment.centerLeft
                                    : Alignment.centerRight,
                            child: Text(
                              AppLocalizations.of(context)!.max,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * .02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${_minDiscount.toStringAsFixed(0)}\%",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          Text(
                            "${_maxDiscount.toStringAsFixed(0)}\%",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Slider(
                              activeColor: Colors.green,
                              value: _discount,
                              min: _minDiscount,
                              max: _maxDiscount,
                              label: "${_discount.toStringAsFixed(0)}%",
                              onChanged: (value) {
                                setState(() {
                                  _discount = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: height * .025),
                  Text(
                    AppLocalizations.of(context)!.category,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: height*.01,),

                  Wrap(
                    spacing: 8,
                    children:
                        categories.map((category) {
                          return ChoiceChip(
                            showCheckmark: false,
                            selectedColor: AppColors.primaryColor,
                            backgroundColor: Colors.white,
                            label: Text(
                              category,
                              style: TextStyle(
                                color:
                                    selectedCategory == category
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                            selected: selectedCategory == category,
                            onSelected: (selected) {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                          );
                        }).toList(),
                  ),
                  SizedBox(height: height*.02,),

                  // Location Selection
                  Text(
                    AppLocalizations.of(context)!.location,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: height*.01,),
                  ToggleButtons(
                    selectedColor: Theme.of(context).textTheme.bodyLarge?.color,
                    // text color when selected
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    // text color when NOT selected
                    fillColor: AppColors.primaryColor,

                    // background when selected
                    //borderColor: AppColors.primaryColor,           // optional
                    // optional
                    borderRadius: BorderRadius.circular(10),
                    isSelected: List.generate(
                      locationOptions.length,
                      (index) => index == _selectedLocation,
                    ),
                    onPressed: (index) {
                      setState(() {
                        _selectedLocation = index;
                      });
                    },
                    children:
                        locationOptions
                            .map(
                              (e) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text(e),
                              ),
                            )
                            .toList(),
                  ),

                  SizedBox(height: height*.02,),

                  // Dishes Selection
                  Text(
                    AppLocalizations.of(context)!.dish,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  SizedBox(height: height*.01,),

                  Wrap(
                    spacing: 8,
                    children:
                        getFilteredDishes().map((dish) {
                          if (selectedCategory.isEmpty) {
                            selectedCategory =
                                AppLocalizations.of(context)!.all;
                          }
                          return FilterChip(
                            showCheckmark: false,
                            label: Text(
                              dish["name"]!,
                              style: TextStyle(
                                color:
                                    _selectedDishes.contains(dish["name"])
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                            selected: _selectedDishes.contains(dish["name"]!),
                            selectedColor: AppColors.primaryColor,
                            backgroundColor: Colors.white,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedDishes.add(dish["name"]!);
                                } else {
                                  _selectedDishes.remove(dish["name"]!);
                                }
                                setState(() {});
                              });
                            },
                          );
                        }).toList(),
                  ),

                  SizedBox(height: 24),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: SizedBox(
                  //     width: double.infinity,
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         Navigator.pop(context);
                  //       },
                  //       child: Text("Apply Filters"),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
