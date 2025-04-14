// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:foodtek/constant/colors.dart';

import 'package:foodtek/core/responseve.dart';
import 'package:foodtek/view/screen/auth/login.dart';

class CustomAuthCard extends StatelessWidget {
  final String title;
  final String? description;
  final String? descriptionword;
  final String backTo;
  final String login;
  final String page;
  final List<Widget> children;
  final void Function()? descriptionWordOnTap;
  final TextAlign titleAlign, descriptionAlign;
  final bool arrowIcon;

  const CustomAuthCard({
    super.key,
    required this.title,
    this.description,
    required this.arrowIcon,
    required this.children,
    required this.backTo,
    required this.login,
    required this.page,
    required this.titleAlign,
    required this.descriptionAlign,
    this.descriptionword,
    this.descriptionWordOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  arrowIcon
                      ? IconButton(
                        // back arrow
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                        padding: EdgeInsets.only(right: 25),
                      )
                      : SizedBox(),
                  Text(backTo), // the text next to the back arrow
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      login,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(page),
                ],
              ),

              Text(
                // the rest password text
                title,
                textAlign: titleAlign,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              if (description != null) ...[
                // the description under it
                const SizedBox(height: 10),
                SizedBox(
                  width: responsiveWidth(context, 295),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        description!,
                        textAlign: descriptionAlign,
                        style: TextStyle(fontSize: 12),
                      ),

                      GestureDetector(
                        onTap: descriptionWordOnTap,
                        child: Text(
                          descriptionword!,
                          textAlign: descriptionAlign,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}
