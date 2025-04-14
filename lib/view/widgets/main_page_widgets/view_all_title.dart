// the view all button on the right of the top rated and the recommended
import 'package:flutter/material.dart';
import 'package:foodtek/constant/colors.dart';


class ViewAllTitleRow extends StatelessWidget {
  final String title;
  final VoidCallback onView;
  final bool vis;

  const ViewAllTitleRow({super.key, required this.title, required this.onView,required this.vis});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.onBoardingtextColor,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Visibility(
          visible: vis,
          child: TextButton(
            onPressed: onView,
            child: Text(
              "View all",
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
