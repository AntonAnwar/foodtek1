import 'package:flutter/material.dart';
import 'package:foodtek/view/screen/auth/OTP/reset_password_screen.dart';
import 'package:foodtek/view/widgets/auth/OTP/reusable_scaffold.dart';
import '../../../../core/responseve.dart';
import '../../../widgets/auth/custom_foodtek_logo_widget.dart';
import '../../../widgets/auth/OTP/custom_otp_text_field.dart';
import '../../../widgets/auth/foodtek_button.dart';

class OtpScreen extends StatefulWidget {
  final VoidCallback? onPressed;
  const OtpScreen({super.key, required this.onPressed});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(
      child: SingleChildScrollView(
        // to Ensure a Scrollable view
        child: Column(
          children: [
            CustomFoodtekLogoWidget(), // custom logo
            Center(
              // Password Reset Card
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Image.asset(
                              // the image
                              "assets/images/auth/reset_password.png",
                              height: responsiveHeight(context, 153),
                              width: responsiveWidth(context, 153),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "A 4-digit code has been sent to your email. Please enter it to verify.",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      CustomOtpTextField(),
                      const SizedBox(height: 40),

                      /// Submit Button
                      FoodtekButton(
                        text: "Verify",
                        onPressed: () {
                          if (widget.onPressed != null) {
                            widget.onPressed!(); // Call the passed function
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResetPasswordScreen(),
                              ),
                            );
                          }
                        },
                        // widget.onPressed ?? () {
                        //   Navigator.push(context, MaterialPageRoute(builder: (context) => ResetPasswordScreen(),));
                        // },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
