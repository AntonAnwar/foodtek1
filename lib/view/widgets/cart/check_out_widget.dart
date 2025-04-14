import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CheckOutWidget extends StatelessWidget {
  void Function()? onPressed;
  final double subtotel;
  CheckOutWidget({super.key, required this.subtotel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/pattern.png",

              fit: BoxFit.cover,
              // Ensures the image covers the entire screen
              color: const Color.fromARGB(255, 26, 92, 45),
              // Adjust opacity for transparency
              colorBlendMode:
                  BlendMode.modulate, // Blends color with background
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildCheckoutRow('Sub-Total', subtotel),
              buildCheckoutRow('Delivery Charge', 10),
              buildCheckoutRow('Discount', 10),
              const Divider(color: Colors.white30),
              buildCheckoutRow('Total:', subtotel + 20, isTotal: true),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Place My Order',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCheckoutRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
            ),
          ),
          Text(
            "$value \$",
            style: TextStyle(
              color: Colors.white,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
