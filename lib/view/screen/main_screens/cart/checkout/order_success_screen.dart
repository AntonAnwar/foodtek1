import 'package:flutter/material.dart';
import 'package:foodtek/view/screen/main_screens/main_page.dart';
import 'package:foodtek/view/widgets/auth/foodtek_button.dart';

import '../../history/order_details_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.checkout,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Success illustration
            Image.asset("assets/images/mainPage/checkout/success_order.png"),

            SizedBox(height: 40),

            // Success text
            Text(
              AppLocalizations.of(context)!.your_order_done_successfully,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            Text(
              '${AppLocalizations.of(context)!.you_will_get_your_order_within} 12min.',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),

            Text(
              AppLocalizations.of(context)!.thanks_for_using_our_services,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40),

            // Track order button
            FoodtekButton(
              text: AppLocalizations.of(context)!.track_your_order,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
