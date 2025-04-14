import 'package:flutter/material.dart';

import '../../../constant/colors.dart';

class TabButton extends StatelessWidget {// the buttons in the main page bottom sheet
  final VoidCallback onTap;
  final String title;
  final String icon;
  final bool isSelected;

  const TabButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 15,
            height: 15,
            color:
                isSelected
                    ? AppColors.primaryColor
                    : AppColors.onBoardingtextColor,
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color:
                  isSelected
                      ? AppColors.primaryColor
                      : AppColors.onBoardingtextColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
