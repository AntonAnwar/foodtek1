import 'package:flutter/material.dart';
import 'package:foodtek/constant/colors.dart';
import 'package:foodtek/view/screen/main_screens/history/chat.dart';
import 'package:foodtek/view/screen/main_screens/history/delivery_tracking_screen.dart';
import 'package:foodtek/view/widgets/auth/foodtek_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  Widget statusStep(IconData icon, String text, bool isDone) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: isDone ? Colors.green : Colors.grey, size: 30),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: isDone ? Colors.black : Colors.grey,
              fontWeight: isDone ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // IconButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                //   icon: Icon(Icons.arrow_back),
                // ),
                const Text(
                  "Order Details",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Image.asset(
                  'assets/images/mainPage/location/img.png',
                  width: 40,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order ID",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "#OD3849384",
                      style: TextStyle(color: AppColors.onBoardingtextColor),
                    ),
                    Text("25m"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            statusStep(Icons.check_circle, "Order received", true),
            const SizedBox(height: 16),
            statusStep(Icons.local_fire_department, "Cooking your order", true),
            const SizedBox(height: 16),
            statusStep(
              Icons.delivery_dining,
              "Courier is picking up order",
              false,
            ),
            const SizedBox(height: 30),
            statusStep(Icons.home, "Order delivered", false),

            const SizedBox(height: 20),
            const Divider(),

            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/mainPage/location/img_1.png',
                  ),
                  radius: 25,
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Delivery Hero",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "Alexander V.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        Text(" 4.9"),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.call, color: Colors.green),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen:  ChatPage(),
                      withNavBar: false, // OPTIONAL VALUE. True by default.
                      pageTransitionAnimation: PageTransitionAnimation.cupertino,
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ChatPage()),
                    // );
                  },
                  icon: Icon(Icons.message, color: Colors.orange),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Text("your Location"),
            SizedBox(height: 15),
            const Row(
              children: [
                Icon(Icons.location_on, color: Colors.green),
                SizedBox(width: 8),
                Flexible(
                  child: Text("123 Al-Madina Street, Abdali, Amman, Jordan"),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Center(
              child: FoodtekButton(
                text: "Live Track",
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen:  DeliveryTrackingScreen(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => DeliveryTrackingScreen(),
                  //   ),
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
