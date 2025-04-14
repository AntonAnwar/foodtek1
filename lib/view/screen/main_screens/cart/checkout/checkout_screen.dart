import 'package:flutter/material.dart';
import 'package:foodtek/view/screen/main_screens/cart/checkout/add_card_screen.dart';
import 'package:foodtek/view/widgets/cart/check_out_widget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Checkout',
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
        child: ListView(
          children: [
            Text(
              'Pay With:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Address selection
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Radio(
                    value: true,
                    groupValue: true,
                    onChanged: (value) {},
                    activeColor: Color(0xFF32B768),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '88 Zurab Gorgiladze St',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Georgia, Batumi',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Radio(
                    value: false,
                    groupValue: true,
                    onChanged: (value) {},
                    activeColor: Color(0xFF32B768),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '5 Noe Zhordania St',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Georgia, Batumi',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(width: 80),
                  Text(
                    'Change',
                    style: TextStyle(
                      color: Color(0xFF32B768),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Promo code
            Text(
              'Promo Code?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Your Promo',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF32B768),
                    foregroundColor: Colors.white,
                    minimumSize: Size(80, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Add'),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Payment method
            Text(
              'Pay With:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: Color(0xFF32B768),
                ),
                Text('Card', style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(width: 20),
                Radio(
                  value: false,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: Color(0xFF32B768),
                ),
                Text('Cash', style: TextStyle(color: Colors.grey)),
              ],
            ),

            SizedBox(height: 15),

            // Card type
            Text(
              'Card Type:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Radio(
                  value: true,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: Color(0xFF32B768),
                ),
                Image.asset(
                  "assets/images/mainPage/checkout/Mastercard.png",
                  height: 25,
                ),
                SizedBox(width: 20),
                Radio(
                  value: false,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: Color(0xFF32B768),
                ),
                Image.asset(
                  "assets/images/mainPage/checkout/Visa.png",
                  height: 25,
                ),
              ],
            ),

            SizedBox(height: 25),
            CheckOutWidget(
              subtotel: 100,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCardScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
