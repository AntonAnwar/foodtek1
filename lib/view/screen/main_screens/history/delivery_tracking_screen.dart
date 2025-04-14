import 'package:flutter/material.dart';
import 'package:foodtek/constant/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/main_page_widgets/round_textfield.dart';
import 'order_details_page.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  const DeliveryTrackingScreen({super.key});

  @override
  State<DeliveryTrackingScreen> createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  String? address; // for the address it is currently being saved in  SharedPreferences

  @override
  void initState() {
    super.initState();
    loadAddress(); // to load the address
  }

  Future<void> loadAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address = prefs.getString('address');
    });
  }

  late GoogleMapController mapController;

  final LatLng _deliveryLocation = LatLng(32.963158, 35.930359);
  final LatLng _currentLocation = LatLng(32.960158, 35.925359);

  @override
  Widget build(BuildContext context) {
    TextEditingController txtSearch = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          // Static image replacing the map
          Stack(
            children: [
              // SizedBox(
              //   height: 500,
              //   width: double.infinity,
              //   child: Image.asset(
              //     'assets/images/mainPage/location/loaction.png',
              //     fit: BoxFit.cover,
              //   ),
              // ),
              SizedBox(
                height: 500,
                width: double.infinity,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation,
                    zoom: 15,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('current'),
                      position: _currentLocation,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueBlue,
                      ),
                    ),
                    Marker(
                      markerId: MarkerId('destination'),
                      position: _deliveryLocation,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen,
                      ),
                    ),
                  },
                  onMapCreated: (controller) {
                    setState(() {
                      mapController = controller;
                    });
                  },
                ),
              ),
              // Overlay Row (Back + Search)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RoundTextfield(
                          hintText: "Search menu, restaurant or etc",
                          controller: txtSearch,
                          left: Container(
                            alignment: Alignment.center,
                            width: 30,
                            child: const Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "On The Way",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => OrderDetailsPage(),
                        //   ),
                        // );
                      },
                      child: Text(
                        "All Details",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Placed ",
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                    Text(
                      " On The Way ",
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                    Text(
                      " Delivered",
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ],
                ),

                Divider(height: 32),
                SizedBox(height: 15),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/images/mainPage/location/img_1.png',
                      ),
                      radius: 25,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Delivery Hero",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Row(
                          children: [
                            Text(
                              "Alexander V.",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 16,
                                ),
                                Text(" 4.9"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.call, color: Colors.green),
                    SizedBox(width: 16),
                    Icon(Icons.message, color: Colors.orange),
                  ],
                ),

                SizedBox(height: 24),

                Text("Your location"),
                SizedBox(height: 4),
                Text("$address", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}
