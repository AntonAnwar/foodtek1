import 'package:flutter/material.dart';
import 'package:foodtek/model/item.dart';
import 'package:foodtek/view/screen/main_screens/cart/checkout/location_screeen.dart';
import 'package:foodtek/view/widgets/cart/cart_item_widget.dart';
import 'package:foodtek/view/widgets/cart/check_out_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreennnState();
}

class _CartScreennnState extends State<CartScreen> {
  double totel = 0;
  // List<Item> item = items;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return CartItemWidget(
                title: items[index].title,
                restaurant: items[index].restaurant,
                price: items[index].price,
                imagePath: items[index].image,
              );
            },
          ),
        ),
        CheckOutWidget(
          subtotel: totel,
          onPressed: () {
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen:  LocationScreen(),
              withNavBar: false, // OPTIONAL VALUE. True by default.
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => LocationScreen()),
            // );
          },
        ),
      ],
    );
  }
}
