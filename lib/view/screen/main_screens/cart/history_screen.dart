import 'package:flutter/material.dart';
import 'package:foodtek/view/widgets/auth/foodtek_button.dart';
import 'package:foodtek/view/widgets/main_page_widgets/location_notification_srearch.dart';

import '../../../widgets/cart/empty_cart-widget.dart';
import '../history/order_details_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HistoryScreen extends StatelessWidget {
  bool locationBar = true;

  HistoryScreen({super.key, required this.locationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Background content
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                //LocationNotificationSrearch(showSearchBar: true),
                const SizedBox(height: 15),
                // Your other content goes here...
              ],
            ),
          ),
          EmptyCartwidget(
            title: AppLocalizations.of(context)!.history_empty,
            subtitle: AppLocalizations.of(context)!.empty_product_history,
          ),
          // Bottom Button
          // Positioned(
          //   bottom: 40,
          //   left: 16,
          //   right: 16,
          //   child: FoodtekButton(
          //     text: "Track your order",
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => OrderDetailsPage()),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
