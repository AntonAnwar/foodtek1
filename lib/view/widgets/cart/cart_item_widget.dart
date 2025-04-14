// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodtek/constant/colors.dart';
import 'package:foodtek/core/responseve.dart';

class CartItemWidget extends StatelessWidget {
  final String title;
  final String restaurant;
  final double price;
  final String imagePath;
  const CartItemWidget({
    super.key,
    required this.title,
    required this.restaurant,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        color: Color.fromARGB(255, 253, 171, 29),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Implement your delete logic here
        // For example: Provider.of<CartProvider>(context, listen: false).removeItem(itemId);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                SizedBox(
                  width: responsiveWidth(context, 65),
                  height: responsiveHeight(context, 65),
                  child: Center(
                    child: Image.asset(
                      "assets/images/mainPage/home_page_images/top_list_images/Pizza.png",
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        restaurant,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "\$ $price",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: responsiveWidth(context, 95),
                  height: responsiveHeight(context, 28),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 236, 233, 233),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.remove, color: Colors.green),
                            onPressed: () {
                              // counter--;
                              // setState(() {});
                            },
                            iconSize: 18,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "1",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add, color: Colors.white),
                            onPressed: () {
                              // counter++;
                              // setState(() {});
                            },
                            iconSize: 18,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // Stack(
    //   children: [
    //     SingleChildScrollView(
    //       child: Column(
    //         children: [

    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    //   child: Container(
    //     height: 120,
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(12),
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.1),
    //           spreadRadius: 1,
    //           blurRadius: 3,
    //           offset: const Offset(0, 1),
    //         ),
    //       ],
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(12.0),
    //       child: Row(
    //         children: [
    //           SizedBox(
    //             width: responsiveWidth(context, 65),
    //             height: responsiveHeight(context, 65),
    //             child: Center(
    //               child: Image.asset(
    //                 "assets/images/mainPage/home_page_images/top_list_images/Pizza.png",
    //               ),
    //             ),
    //           ),

    //           const SizedBox(width: 16),
    //           Expanded(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   title,
    //                   style: const TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 16,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 4),
    //                 Text(
    //                   restaurant,
    //                   style: TextStyle(
    //                     color: Colors.grey.shade500,
    //                     fontSize: 12,
    //                   ),
    //                 ),
    //                 const SizedBox(height: 4),
    //                 Text(
    //                   "\$ $price",
    //                   style: const TextStyle(
    //                     color: Colors.green,
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 16,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             width: responsiveWidth(context, 95),
    //             height: responsiveHeight(context, 28),
    //             padding: const EdgeInsets.all(4),
    //             // decoration: BoxDecoration(
    //             //   color: Colors.green.withOpacity(0.1),
    //             //   borderRadius: BorderRadius.circular(8),
    //             // ),
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       color: const Color.fromARGB(255, 236, 233, 233),

    //                       borderRadius: BorderRadius.circular(4),
    //                     ),

    //                     child: IconButton(
    //                       icon: const Icon(Icons.remove, color: Colors.green),
    //                       onPressed: () {
    //                         // counter--;
    //                         // setState(() {});
    //                       },
    //                       iconSize: 18,
    //                       padding: EdgeInsets.zero,
    //                       constraints: const BoxConstraints(),
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(width: 8),
    //                 Expanded(
    //                   child: Text(
    //                     "1",
    //                     style: TextStyle(fontWeight: FontWeight.bold),
    //                   ),
    //                 ),
    //                 const SizedBox(width: 8),
    //                 Expanded(
    //                   child: Container(
    //                     decoration: BoxDecoration(
    //                       color: AppColors.primaryColor,

    //                       borderRadius: BorderRadius.circular(4),
    //                     ),
    //                     child: IconButton(
    //                       icon: const Icon(Icons.add, color: Colors.white),
    //                       onPressed: () {
    //                         // counter++;
    //                         // setState(() {});
    //                       },
    //                       iconSize: 18,
    //                       padding: EdgeInsets.zero,
    //                       constraints: const BoxConstraints(),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           // const SizedBox(width: 8),
    //           // IconButton(
    //           //   icon: const Icon(Icons.delete_outline, color: Colors.red),
    //           //   onPressed: () {},
    //           // ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

    // _buildCartItem(
    //   'Spicy Shawarma',
    //   'Hot Cool Spot',
    //   15,
    //   "assets/images/mainPage/home_page_images/top_list_images/Pizza.png",
    // ),
    // _buildCartItem(
    // 'Chicken Burger',
    // 'Burger Factory LTD',
    // 20,
    // "assets/images/mainPage/home_page_images/top_list_images/Pizza.png",
    // ),
    // _buildCartItem(
    //   'Onion Pizza',
    //   'Pizza Palace',
    //   15,
    //   "assets/images/mainPage/home_page_images/top_list_images/Pizza.png",
    // ),
    // _buildCartItem(
    //   'Spicy Shawarma',
    //   'Hot Cool Spot',
    //   15,
    //   "assets/images/mainPage/home_page_images/top_list_images/Pizza.png",
    // ),
    // const SizedBox(height: 200), // Space for the checkout panel
    //         ],
    //       ),
    //     ),
    //     //  Positioned(bottom: 0, left: 0, right: 0, child: _buildCheckoutPanel()),
    //   ],
    // );
  }
}

//   Widget _buildCartItem(
//     String title,
//     String restaurant,
//     int price,
//     String imagePath,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Container(
//         height: 120,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 3,
//               offset: const Offset(0, 1),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: responsiveWidth(context, 65),
//                 height: responsiveHeight(context, 65),
//                 child: Center(
//                   child: Image.asset(
//                     "assets/images/mainPage/home_page_images/top_list_images/Pizza.png",
//                   ),
//                 ),
//               ),

//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       restaurant,
//                       style: TextStyle(
//                         color: Colors.grey.shade500,
//                         fontSize: 12,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '\$ $price',
//                       style: const TextStyle(
//                         color: Colors.green,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 width: responsiveWidth(context, 95),
//                 height: responsiveHeight(context, 28),
//                 padding: const EdgeInsets.all(4),
//                 // decoration: BoxDecoration(
//                 //   color: Colors.green.withOpacity(0.1),
//                 //   borderRadius: BorderRadius.circular(8),
//                 // ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: const Color.fromARGB(255, 236, 233, 233),

//                           borderRadius: BorderRadius.circular(4),
//                         ),

//                         child: IconButton(
//                           icon: const Icon(Icons.remove, color: Colors.green),
//                           onPressed: () {
//                             counter--;
//                             setState(() {});
//                           },
//                           iconSize: 18,
//                           padding: EdgeInsets.zero,
//                           constraints: const BoxConstraints(),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         "$counter",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: AppColors.primaryColor,

//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: IconButton(
//                           icon: const Icon(Icons.add, color: Colors.white),
//                           onPressed: () {
//                             counter++;
//                             setState(() {});
//                           },
//                           iconSize: 18,
//                           padding: EdgeInsets.zero,
//                           constraints: const BoxConstraints(),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // const SizedBox(width: 8),
//               // IconButton(
//               //   icon: const Icon(Icons.delete_outline, color: Colors.red),
//               //   onPressed: () {},
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
