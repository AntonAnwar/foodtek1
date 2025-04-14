// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodtek/view/screen/main_screens/cart/checkout/checkout_screen.dart';
import 'package:foodtek/view/widgets/auth/foodtek_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? mapController;
  List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map background
          Container(color: Color(0xFFEAEAEA)),

          // Map roads and markers
          Positioned.fill(
            child: GoogleMap(
              mapToolbarEnabled: true,
              mapType:
                  MapType
                      .normal, // نوع الخريطة، هنا يتم استخدام النمط الهجين (Hybrid) الذي يجمع بين الخريطة العادية وصور الأقمار الصناعية
              myLocationButtonEnabled:
                  true, // تفعيل زر تحديد الموقع الحالي للمستخدم على الخريطة

              myLocationEnabled:
                  true, // إظهار موقع المستخدم الحالي على الخريطة إذا كانت الصلاحيات مفعلة

              markers:
                  markers
                      .toSet(), // تحديد العلامات (Markers) التي ستظهر على الخريطة، يتم تحويل القائمة إلى Set
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  31.952409734006356,
                  35.90800244361162,
                ), // تحديد الموقع الأولي الذي سيتم عرض الخريطة عنده (إحداثيات خط العرض والطول)
                zoom: 15, // مستوى التقريب (Zoom) عند تحميل الخريطة
              ),
              onMapCreated: (controller) {
                mapController = controller;
              },
              onTap: (LatLng latlang) {
                markers.clear();
                print(
                  "============================value.latitude = ${latlang.latitude}===========================================",
                );
                print(
                  "============================value.longitude = ${latlang.longitude}=========================================",
                );
                markers.add(
                  Marker(
                    markerId: MarkerId("${latlang.latitude}"),
                    position: LatLng(latlang.latitude, latlang.longitude),
                  ),
                );
                setState(() {});
              },
            ),
          ),

          // Location search bar
          Positioned(
            top: 40,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Find your location',
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //  Location confirmation card
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'your location',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(height: 8),

                  Row(
                    children: [
                      Icon(Icons.location_on, color: Color(0xFF32B768)),
                      SizedBox(width: 8),
                      Text(
                        '123 Al-Madina Street, Abdali,\n Amman, Jordan',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),
                  FoodtekButton(
                    text: "Set Location",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
