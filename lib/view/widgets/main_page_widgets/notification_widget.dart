import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void openNotificationSheet(BuildContext context) {
  showModalBottomSheet(
    // the bottom sheet
    context: context,
    //backgroundColor: Colors.transparent,
    isScrollControlled: true,
    // Makes the bottom sheet more flexible
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => NotificationWidget(),
  );
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      //Color.fromRGBO(219, 244, 209, 0.5),
      height: MediaQuery.of(context).size.height * 0.65, // Almost full-screen
      padding: EdgeInsets.all(16),
      child: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.notification,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert_outlined),
                ),
              ],
            ),
            SizedBox(height: 10),
            TabBar(
              labelColor: Theme.of(context).textTheme.bodyLarge?.color,
              indicatorColor: Colors.green,
              tabs: [
                Tab(text: AppLocalizations.of(context)!.all),
                Tab(text: AppLocalizations.of(context)!.unread),
                Tab(text: AppLocalizations.of(context)!.read),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  _buildNotificationList(context),
                  _buildNotificationList(context),
                  _buildNotificationList(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList(BuildContext context) {
    return ListView(
      children: [
        _buildNotificationItem(
          "Delayed Order :",
          "We’re sorry! Your order is running late. New ETA: 10:30 PM. Thanks for your patience!",
          context: context,
        ),
        _buildNotificationItem(
          "Promotional Offer",
          "Craving something delicious? 🍔 Get 20% off on your next order. Use code: YUMMY20",
          context: context,
        ),
        _buildNotificationItem(
          "Out for Delivery",
          "Your order is on the way! 🚗 Estimated arrival: 15 mins. Stay hungry!",
          context: context,
        ),
        _buildNotificationItem(
          "Order Confirmation",
          "Your order has been placed! 🍔 We're preparing it now. Track your order live",
          context: context,
        ),
        _buildNotificationItem(
          "Delivered",
          "Enjoy your meal! 🍕 Your order has been delivered. Rate your experience!",
          context: context,
        ),
      ],
    );
  }

  Widget _buildNotificationItem(
    String title,
    String subtitle, {
    required BuildContext context,
  }) {
    return ListTile(
      //tileColor: Color.fromRGBO(219, 244, 209, 0.5),
      onTap: () {},
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color,
        ),
      ),
    );
  }
}
