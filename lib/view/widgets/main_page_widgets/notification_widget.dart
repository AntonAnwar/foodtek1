import 'package:flutter/material.dart';

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
      height: MediaQuery.of(context).size.height * 0.85, // Almost full-screen
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
                    "Notifications",
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
              tabs: [Tab(text: "All"), Tab(text: "Unread"), Tab(text: "Read")],
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
        _buildNotificationItem("Delayed Order", "Your order is running late."),
        _buildNotificationItem(
          "Promotional Offer",
          "Get 20% off your next order.",
        ),
        _buildNotificationItem("Out for Delivery", "Your order is on the way!"),
        _buildNotificationItem(
          "Order Confirmation",
          "Your order has been placed.",
        ),
        _buildNotificationItem("Delivered", "Your order has been delivered."),
      ],
    );
  }

  Widget _buildNotificationItem(String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () {},
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
