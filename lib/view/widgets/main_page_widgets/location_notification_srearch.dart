// this class is used to display the location and the search bar and the Notifications

import 'package:flutter/material.dart';
import 'package:foodtek/view/widgets/main_page_widgets/round_textfield.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/colors.dart';
import '../../screen/main_screens/home/filter_screen.dart';
import 'notification_widget.dart';

class LocationNotificationSrearch extends StatefulWidget {
  final bool showSearchBar; // to show the SearchBar where needed

  const LocationNotificationSrearch({super.key, required this.showSearchBar});

  @override
  State<LocationNotificationSrearch> createState() =>
      _LocationNotificationSrearchState();
}

class _LocationNotificationSrearchState
    extends State<LocationNotificationSrearch> {
  String?
  address; // for the address it is currently being saved in  SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadAddress(); // to load the address
  }

  Future<void> _loadAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address = prefs.getString('address');
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtSearch = TextEditingController();
    return Column(
      children: [
        const SizedBox(height: 20),
        // Location & Notification Row
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Image.asset(
                "assets/images/mainPage/location.png",
                width: 34,
                height: 34,
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                // to display the map to chose the location
                // to be implemented
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivering to",
                      style: TextStyle(
                        color: AppColors.onBoardingtextColor,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        address == null
                            ? Text(
                              // if the user didnt allow the location
                              "Current Location",
                              style: TextStyle(
                                color: AppColors.onBoardingtextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                            : Text(
                              // if the user did allow the location
                              '$address',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 10),
                            ),

                        const SizedBox(width: 5),
                        Image.asset(
                          // the arrow at the end
                          "assets/images/mainPage/dropDownIcon.png",
                          width: 18,
                          height: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: IconButton(
                onPressed: () => openNotificationSheet(context),
                icon: Image.asset(
                  "assets/images/mainPage/img.png",
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Search Bar
        Visibility(
          visible: widget.showSearchBar,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: RoundTextfield(
              hintText: "Search menu, restaurant or etc",
              controller: txtSearch,
              left: Container(
                alignment: Alignment.center,
                width: 30,
                child: Icon(Icons.search),
              ),
              right: IconButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen:  FilterScreen(),
                    withNavBar: false, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => FilterScreen()),
                  // );
                },
                icon: Image.asset(
                  'assets/images/mainPage/filterIcon.png',
                  width: 18,
                  height: 18,
                ),

                alignment: Alignment.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
