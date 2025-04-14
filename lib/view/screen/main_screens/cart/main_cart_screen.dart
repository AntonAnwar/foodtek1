import 'package:flutter/material.dart';
import 'package:foodtek/view/screen/main_screens/cart/cart_screen.dart';
import 'package:foodtek/view/screen/main_screens/cart/history_screen.dart';
import 'package:foodtek/view/widgets/main_page_widgets/location_notification_srearch.dart';

class MainCartPage extends StatefulWidget {
  const MainCartPage({super.key});

  @override
  State<MainCartPage> createState() => _CartPageState();
}

class _CartPageState extends State<MainCartPage>
    with SingleTickerProviderStateMixin {
  int counter = 1;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // void _toggleCartEmpty() {
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            LocationNotificationSrearch(showSearchBar: false),
            SizedBox(height: 10),
            buildTabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [CartScreen(), HistoryScreen(locationBar: false)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    _tabController.animateTo(0);
                  },
                  child: Column(
                    children: [
                      Text(
                        "Cart",
                        style: TextStyle(
                          color:
                              _tabController.index == 0
                                  ? Colors.green
                                  : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 40,
                        height: 3,
                        color:
                            _tabController.index == 0
                                ? Colors.green
                                : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _tabController.animateTo(1);
                  },
                  child: Column(
                    children: [
                      Text(
                        "History",
                        style: TextStyle(
                          color:
                              _tabController.index == 1
                                  ? Colors.green
                                  : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 40,
                        height: 3,
                        color:
                            _tabController.index == 1
                                ? Colors.green
                                : Colors.transparent,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
