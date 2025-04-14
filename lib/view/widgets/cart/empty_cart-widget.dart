// ignore_for_file: file_names

import 'package:flutter/material.dart';

class EmptyCartwidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const EmptyCartwidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/empty-cart.png"),
          const SizedBox(height: 24),
          Text(
            title!,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
