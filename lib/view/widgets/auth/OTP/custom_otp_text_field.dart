import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:foodtek/constant/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: must_be_immutable
class CustomOtpTextField extends StatelessWidget {
  void Function(String)? onSubmit;

  CustomOtpTextField({
    super.key,
    this.onSubmit,
    // required this.controller,
    // required this.focusNode,
    // this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.5,
      width: 46,
      child: OtpTextField(
        numberOfFields: 4,
        margin: EdgeInsets.symmetric(horizontal: 8),
        // borderColor: AppColors.primaryColor,
        cursorColor: AppColors.primaryColor,
        focusedBorderColor: AppColors.primaryColor,
        //set to true to show as box or false to show as dash
        showFieldAsBox: true,
        //runs when a code is typed in
        onCodeChanged: (String code) {
          //handle validation or checks here
        },
        //runs when every textfield is filled
        onSubmit: (String verificationCode) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(AppLocalizations.of(context)!.verification_code),
                content: Text('${AppLocalizations.of(context)!.code_entered_is} $verificationCode'),
              );
            },
          );
          onSubmit;
        }, // end onSubmit
      ),
    );
  }
}
