import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../state/auth/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  ResetPasswordCubit() : super(ResetPasswordInitial());

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
}
