import 'package:flutter/material.dart';
import 'package:foodtek/constant/colors.dart';
import 'package:foodtek/core/responseve.dart';
import 'package:foodtek/view/screen/main_screens/history/chat.dart';
import 'package:foodtek/view/screen/main_screens/history/delivery_tracking_screen.dart';
import 'package:foodtek/view/widgets/auth/foodtek_button.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  // Widget statusStep(IconData icon, String text, bool isDone) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Icon(icon, color: isDone ? Colors.green : Colors.grey, size: 30),
  //       const SizedBox(width: 10),
  //       Expanded(
  //         child: Text(
  //           text,
  //           style: TextStyle(
  //             fontSize: 16,
  //             color: isDone ? Colors.black : Colors.grey,
  //             fontWeight: isDone ? FontWeight.w600 : FontWeight.normal,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final steps = [
      {
        'title': AppLocalizations.of(context)!.order_received,
        'icon': "assets/images/mainPage/location/img_2.png",
      },
      {
        'title': AppLocalizations.of(context)!.cooking_your_order,
        'icon': "assets/images/mainPage/location/img_3.png",
      },
      {
        'title': AppLocalizations.of(context)!.courier_is_picking_up_order,
        'icon': "assets/images/mainPage/location/img_4.png",
      },
      {
        'title': AppLocalizations.of(context)!.order_delivered,
        'icon': "assets/images/mainPage/location/img_5.png",
      },
    ];
    int currentStep = 2; // change this to reflect order status

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.order_details,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
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
                        AppLocalizations.of(context)!.order_id,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "#OD3849384",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                      Text(
                        "25m",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge?.color,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),

              /// TIMELINE  the progress bar on the left
              FixedTimeline.tileBuilder(
                theme: TimelineThemeData(
                  nodePosition: 0,
                  indicatorTheme: const IndicatorThemeData(size: 28),
                  connectorTheme: const ConnectorThemeData(thickness: 3.0),
                ),
                builder: TimelineTileBuilder.connected(
                  connectionDirection: ConnectionDirection.after,
                  itemCount: steps.length,
                  contentsBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 32),
                      child: Text(
                        steps[index]['title'] as String,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight:
                              index == currentStep
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                          color:
                              index <= currentStep
                                  ? Theme.of(context).textTheme.bodyLarge?.color
                                  : Colors.grey.shade500,
                        ),
                      ),
                    );
                  },
                  indicatorBuilder: (context, index) {
                    return DotIndicator(
                      size: 40,
                      color: index <= currentStep ? Colors.green : Colors.grey,
                      child: Image.asset(
                        color:
                            index <= currentStep ? Colors.white : Colors.white,
                        steps[index]['icon'] as String,
                        fit: BoxFit.contain,
                        width: responsiveWidth(context, 18),
                        height: responsiveHeight(context, 18),
                      ),
                    );
                  },
                  connectorBuilder:
                      (context, index, ___) => SolidLineConnector(
                        color: index < currentStep ? Colors.green : Colors.grey,
                      ),
                ),
              ),

              const Divider(height: 40),

              /// DELIVERY HERO
              Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/mainPage/location/img_1.png',
                    ),
                    radius: 25,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.your_delivery_hero,
                        style: TextStyle(color: Colors.grey.shade300),
                      ),
                      Text(
                        "Alexander V.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyLarge?.color,
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
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/images/mainPage/location/img_6.png",
                      fit: BoxFit.cover,
                      width: responsiveWidth(context, 30),
                      height: responsiveHeight(context, 30),
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const ChatPage(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ChatPage()),
                      // );
                    },
                    icon: Image.asset(
                      "assets/images/mainPage/location/img_7.png",
                      fit: BoxFit.cover,
                      width: responsiveWidth(context, 30),
                      height: responsiveHeight(context, 30),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Text(AppLocalizations.of(context)!.your_location,style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.green),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "123 Al-Madina Street, Abdali, Amman, Jordan",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              Center(
                child: FoodtekButton(
                  text: AppLocalizations.of(context)!.live_track,
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const DeliveryTrackingScreen(),
                      withNavBar: false,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
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
      ),
    );
  }
}
