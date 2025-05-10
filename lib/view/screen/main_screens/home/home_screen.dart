import 'package:flutter/material.dart';
import '../../../../constant/main_screen/home_screen_data.dart';
import '../../../../model/category.dart';
import '../../../widgets/main_page_widgets/category_cell.dart';
import '../../../widgets/main_page_widgets/location_notification_srearch.dart';
import '../../../widgets/main_page_widgets/promo_banner.dart';
import '../../../widgets/main_page_widgets/view_all_title.dart';
import 'item_details_screen.dart';
import 'item_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;
  late List<Category> allItems;
  late List<Category> topRatedItems;
  late List<Category> recommendedItems;
  late List<String> categories;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    allItems = getItems(context);
    topRatedItems = getTopRatedItems(context);
    recommendedItems = getRecommendedItems(context);
    categories = getCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Category> filteredItems =
        selectedCategory == null ||
                selectedCategory == AppLocalizations.of(context)!.all
            ? allItems
            : allItems
                .where((item) => item.category == selectedCategory)
                .toList();

    Map<String, String> categoryIcons = {
      AppLocalizations.of(context)!.all: "",
      AppLocalizations.of(context)!.burger: "🍔",
      AppLocalizations.of(context)!.pizza: "🍕",
      AppLocalizations.of(context)!.sandwich: "🌭",
    };

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              LocationNotificationSrearch(showSearchBar: true),
              const SizedBox(height: 15),

              // Category filter
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    String categoryName = categories[index];
                    bool isSelected =
                        selectedCategory == categoryName ||
                        (categoryName == AppLocalizations.of(context)!.all &&
                            selectedCategory == null);

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory =
                              categoryName == AppLocalizations.of(context)!.all
                                  ? null
                                  : categoryName;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade100),
                          color: isSelected ? Colors.green[400] : Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            if (categoryIcons[categoryName]?.isNotEmpty ??
                                false) ...[
                              Text(
                                categoryIcons[categoryName]!,
                                style: TextStyle(fontSize: 16,
                                  color: isSelected ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),
                              SizedBox(width: 5),
                            ],
                            Text(
                              categoryName,
                              style: TextStyle(
                                color:Colors.black87 ,
                                //color: isSelected ? Colors.black87 : Theme.of(context).textTheme.bodyLarge?.color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Main content
              if (selectedCategory == null) ...[
                PromoBanner(),
                const SizedBox(height: 20),

                // Top Rated
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ViewAllTitleRow(
                    title: AppLocalizations.of(context)!.top_rated,
                    onView: () {},
                    vis: false,
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: topRatedItems.length,
                      itemBuilder: (context, index) {
                        final item = topRatedItems[index];
                        return CategoryCell(
                          isRecommended: false,
                          cObj: item.title,
                          image: item.image,
                          price: item.price,
                          rating: item.rating,
                          description: item.description,
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => ItemDetailsScreen(
                                        name: item.title,
                                        image: item.image,
                                        price: item.price,
                                        description: item.description,
                                        rating: item.rating,
                                        id: item.id,
                                      ),
                                ),
                              ),
                        );
                      },
                    ),
                  ),
                ),
                // Recommended
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ViewAllTitleRow(
                    title: AppLocalizations.of(context)!.top_recommended,
                    onView: () {},
                    vis: true,
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendedItems.length,
                    itemBuilder: (context, index) {
                      final item = recommendedItems[index];
                      return CategoryCell(
                        isRecommended: true,
                        cObj: item.title,
                        image: item.image,
                        price: item.price,
                        description: item.description,
                        rating: item.rating,
                        onTap:
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => ItemDetailsScreen(
                                      name: item.title,
                                      image: item.image,
                                      price: item.price,
                                      description: item.description,
                                      rating: item.rating,
                                      id: item.id,
                                    ),
                              ),
                            ),
                      );
                    },
                  ),
                ),
              ] else ...[
                // Filtered category items
                Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 110),
                    child: ItemScreen(categoryItems: filteredItems),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
