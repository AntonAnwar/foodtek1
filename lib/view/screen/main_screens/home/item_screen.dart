// import 'package:flutter/material.dart';
// import '../../../../model/category.dart';
// import 'item_details_screen.dart';
//
// class ItemScreen extends StatelessWidget {
//   final List<Category> categoryItems;
//
//   //final List filteredItems;
//
//   const ItemScreen({
//     super.key,
//     required this.categoryItems,
//     //required this.filteredItems,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GridView.builder(
//         padding: EdgeInsets.all(10),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2, // Adjust grid layout
//           childAspectRatio: 0.8,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemCount: categoryItems.length,
//         itemBuilder: (context, index) {
//           final item = categoryItems[index];
//           return InkWell(
//             borderRadius: BorderRadius.circular(15),
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder:
//                       (context) => ItemDetailsScreen(
//                         name: categoryItems[index].title,
//                         image: categoryItems[index].image,
//                         price: categoryItems[index].price,
//                         // Example price list
//                         description: categoryItems[index].description,
//                         // Example description list
//                         rating: categoryItems[index].rating,
//                         id: categoryItems[index].id, // Example ratings list
//                       ),
//                 ),
//               );
//             },
//             child: Stack(
//               children: [
//                 Stack(
//                   children: [
//                     Expanded(child: Image.asset(item.image, fit: BoxFit.cover)),
//                     Expanded(
//                       child: Image.asset(
//                         "assets/images/mainPage/home_page_images/img.png",
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Column(
//                     children: [
//                       // Expanded(
//                       //   child: Image.asset(item.image, fit: BoxFit.cover),
//                       // ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Text(
//                               item.title,
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               item.description,
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                             Text(
//                               item.price,
//                               style: TextStyle(color: Colors.green),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubit/main_cubit/favorites_cubit.dart';
import '../../../../model/category.dart';
import '../../../../core/responseve.dart';
import 'item_details_screen.dart';

class ItemScreen extends StatelessWidget {
  final List<Category> categoryItems;

  const ItemScreen({super.key, required this.categoryItems});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 100, // Add bottom padding to avoid bottom bar!
        left: 10,
        right: 10,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 60,
      ),
      itemCount: categoryItems.length,
      itemBuilder: (context, index) {
        final item = categoryItems[index];

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
                padding: const EdgeInsets.only(top: 45, bottom: 35,left: 10,right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
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
            SizedBox(height: 30,),

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
              child:  BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  final favCubit = context.read<FavoritesCubit>();

                  final favoriteItem = FavoriteItem(
                    id: item.id,
                    name: item.title,
                    image: item.image,
                    price: item.price,
                    description: item.description,
                    rating: item.rating,
                  );

                  final isFav = favCubit.isFavorite(favoriteItem);

                  return CircleAvatar(
                    backgroundColor: Colors.green.shade100,
                    child: IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ?Colors.red :Colors.grey,
                      ),
                      onPressed: () {
                        favCubit.toggleFavorite(favoriteItem);
                      },
                    ),
                  );
                },
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
                    Navigator.push(
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
                    );
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
}
