// for the OTP screens

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../state/auth/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  ResetPasswordCubit() : super(ResetPasswordInitial());

  // for the password validation
  void resetPassword() {
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      emit(
        ResetPasswordError(
          passwordError: password.isEmpty ? "Password cannot be empty" : null,
          confirmPasswordError:
              confirmPassword.isEmpty
                  ? "Confirm Password cannot be empty"
                  : null,
        ),
      );
      return;
    }
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(password)) {
      emit(
        ResetPasswordError(
          passwordError:
              "Enter a strong password, longer than 8 characters with special characters and numbers.",
          confirmPasswordError:
              "Enter a strong password, longer than 8 characters with special characters and numbers.",
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      emit(ResetPasswordError(confirmPasswordError: "Passwords do not match!"));
      return;
    }

    // Emit success state
    emit(ResetPasswordSuccess());
  }
// to check the if its a valid email
  void checkEmail() {
    String email = emailController.text.trim();
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);

    if (!regExp.hasMatch(email)) {
      emit(EmailError(errorMsg: "Invalid email"));
      return;
    } else {
      emit(EmailSuccess());
      return;
    }
  }

  void validateField({required String field, required String value}) {
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String email = emailController.text.trim();

    String? passwordError;
    String? confirmPasswordError;
    String? emailError;

    if (field == 'password') {
      if (value.isEmpty) {
        passwordError = "Password cannot be empty";
      } else {
        final pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
        final regExp = RegExp(pattern);
        if (!regExp.hasMatch(value)) {
          passwordError =
          "Enter a strong password, longer than 8 characters with special characters and numbers.";
        }
      }
    }

    if (field == 'confirmPassword') {
      if (value.isEmpty) {
        confirmPasswordError = "Confirm Password cannot be empty";
      } else if (password.isNotEmpty && password != value) {
        confirmPasswordError = "Passwords do not match!";
      }
    }

    if (field == 'email') {
      final emailPattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      final emailRegExp = RegExp(emailPattern);
      if (!emailRegExp.hasMatch(value)) {
        emailError = "Invalid email";
      }
    }

    // Emit based on field
    if (field == 'email' && emailError != null) {
      emit(EmailError(errorMsg: emailError));
    } else if (field == 'email') {
      emit(EmailSuccess());
    } else {
      emit(
        ResetPasswordError(
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
        ),
      );
    }
  }

}
