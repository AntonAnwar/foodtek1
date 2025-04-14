import 'package:flutter/material.dart';

import '../../../widgets/main_page_widgets/location_notification_srearch.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  FilterScreenState createState() => FilterScreenState();
}

class FilterScreenState extends State<FilterScreen> {
  String _selectedCategory = "All";

  List<Map<String, String>> dishes = [
    {"name": "Cheeseburger", "category": "Fast Food"},
    {"name": "Chocolate Cake", "category": "Dessert"},
    {"name": "Spicy Crab Cakes", "category": "Sea Food"},
    {"name": "Miso-Glazed Cod", "category": "Sea Food"},
    {"name": "Lobster Thermidor", "category": "Sea Food"},
    {"name": "Seafood Paella", "category": "Sea Food"},
    {"name": "Tuna Tartare", "category": "Sea Food"},
    {"name": "Clam Chowder", "category": "Sea Food"},
  ];

  List<String> categories = ["All", "Fast Food", "Sea Food", "Dessert"];

  List<Map<String, String>> getFilteredDishes() {
    if (_selectedCategory == "All") {
      return dishes;
    } else {
      return dishes
          .where((dish) => dish["category"] == _selectedCategory)
          .toList();
    }
  }

  final double _minPrice = 0;
  final double _maxPrice = 108;
  double _price = 0;
  final double _minDiscount = 0;
  final double _maxDiscount = 100;

  double _discount = 50;
  int _selectedLocation = 0;
  final Set<String> _selectedDishes = {}; // Track selected dishes

  // List<String> categories = ["Fast Food", "Sea Food", "Dessert"];
  List<bool> categorySelected = [false, false, false];

  List<String> locationOptions = ["1 KM", "5 KM", "10 KM"];

  List<bool> dishesSelected = List.generate(6, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Filter"), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LocationNotificationSrearch(showSearchBar: false),
            Text("Filter", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            // Price Range
            Text("Price range"),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Min"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Max"),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${_minPrice.toStringAsFixed(0)}",
                  style: TextStyle(fontSize: 16),
                ),
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
                Text(
                  "\$${_maxPrice.toStringAsFixed(0)}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Discount
            Text("Discount"),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Min"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Max"),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "\$${_minDiscount.toStringAsFixed(0)}",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Slider(
                    activeColor: Colors.green,
                    value: _discount,
                    min: _minDiscount,
                    max: _maxDiscount,
                    divisions: 10,
                    label: "${_discount.toStringAsFixed(0)}%",
                    onChanged: (value) {
                      setState(() {
                        _discount = value;
                      });
                    },
                  ),
                ),
                Text(
                  "\$${_maxDiscount.toStringAsFixed(0)}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Category Selection
            // Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
            // Wrap(
            //   spacing: 8,
            //   children: List.generate(categories.length, (index) {
            //     return ChoiceChip(
            //       label: Text(categories[index]),
            //       selected: categorySelected[index],
            //       onSelected: (selected) {
            //         setState(() {
            //           categorySelected[index] = selected;
            //         });
            //       },
            //     );
            //   }),
            // ),
            Text("Category", style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children:
                  categories.map((category) {
                    return ChoiceChip(
                      label: Text(category),
                      selected: _selectedCategory == category,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                    );
                  }).toList(),
            ),
            SizedBox(height: 16),

            SizedBox(height: 16),

            // Location Selection
            Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
            ToggleButtons(
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

            SizedBox(height: 16),

            // Dishes Selection
            Text("Dishes", style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children:
                  getFilteredDishes().map((dish) {
                    return FilterChip(
                      label: Text(dish["name"]!),
                      selected: _selectedDishes.contains(dish["name"]!),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            _selectedDishes.add(dish["name"]!);
                          } else {
                            _selectedDishes.remove(dish["name"]!);
                          }
                        });
                      },
                    );
                  }).toList(),
            ),

            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Apply Filters"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
