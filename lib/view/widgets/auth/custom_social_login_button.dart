// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class CustomSocialLoginButton extends StatelessWidget {
//   String? text;
//   String? iconPath;
//   Color? color = Colors.white;
//   Color? textColor = Colors.black;

//   CustomSocialLoginButton({
//     super.key,
//     required this.iconPath,
//     required this.text,
//     this.color,
//     this.textColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         padding: EdgeInsets.symmetric(vertical: 14),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//           side: BorderSide(
//             color: Colors.grey[300]!,
//             width: color == Colors.white ? 1 : 0,
//           ),
//         ),
//         elevation: 0,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset(iconPath!, width: 24, height: 24),
//           SizedBox(width: 12),
//           Text(
//             text!,
//             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class CustomSocialLoginButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback? onPressed;

  const CustomSocialLoginButton({
    super.key,
    required this.text,
    required this.iconPath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey[300]!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, height: 24, width: 24),
            SizedBox(width: 12),
            Text(text, style: TextStyle(color: Colors.black87, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
