import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFelidWidget extends StatelessWidget {
  TextEditingController? controller;
  String label, hintText;
  Widget? suffixIcon;
  final TextInputType type;
  final bool obscure;
  final String? errorText;
  final ValueChanged onChange;
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
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          validator: validator,
          forceErrorText: errorText,
          controller: controller,
          keyboardType: type,
          obscureText: obscure,
          onChanged: onChange,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            suffixIcon: suffixIcon ?? SizedBox(),
            errorText: errorText,
            filled: true,
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              //borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
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
