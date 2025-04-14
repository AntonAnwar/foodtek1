import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFelidWidget extends StatelessWidget {
  

  TextEditingController? controller;
  String label, hintText;
  Widget? suffixIcon;
  final TextInputType type;
  final bool obscure;
  final String? errorText;
  FormFieldValidator<String>? validator;

  CustomTextFelidWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.label,
    this.suffixIcon,
    required this.type,
    required this.obscure,
    this.errorText,
    this.validator, 
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
        SizedBox(height: 8),
        TextFormField( 
          validator: validator,
          forceErrorText: errorText,
          controller: controller,
          keyboardType: type,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon ?? SizedBox(),
            errorText: errorText,
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF38B443), width: 1),
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
