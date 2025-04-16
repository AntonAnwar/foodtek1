import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void openNotificationSheet(BuildContext context) {
  showModalBottomSheet(
    // the bottom sheet
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true, // Makes the bottom sheet more flexible
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
      color:  Color.fromRGBO(219, 244, 209, 0.5),
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
                    "${AppLocalizations.of(context)!.notification}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              labelColor: Colors.black,
              indicatorColor: Colors.green,
              tabs: [Tab(text: AppLocalizations.of(context)!.all), Tab(text: AppLocalizations.of(context)!.unread), Tab(text: AppLocalizations.of(context)!.read)],
            ),
            SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                children: [
                  _buildNotificationList(),
                  _buildNotificationList(),
                  _buildNotificationList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView(
      children: [
        _buildNotificationItem("Delayed Order :", "We’re sorry! Your order is running late. New ETA: 10:30 PM. Thanks for your patience!"),
        _buildNotificationItem(
          "Promotional Offer",
          "Craving something delicious? 🍔 Get 20% off on your next order. Use code: YUMMY20",
        ),
        _buildNotificationItem("Out for Delivery", "Your order is on the way! 🚗 Estimated arrival: 15 mins. Stay hungry!"),
        _buildNotificationItem(
          "Order Confirmation",
          "Your order has been placed! 🍔 We're preparing it now. Track your order live",
        ),
        _buildNotificationItem("Delivered", "Enjoy your meal! 🍕 Your order has been delivered. Rate your experience!"),
      ],
    );
  }

  Widget _buildNotificationItem(String title, String subtitle) {
    return ListTile(
      //tileColor: Color.fromRGBO(219, 244, 209, 0.5),
      onTap: () {},
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }
}
