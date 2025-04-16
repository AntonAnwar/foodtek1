import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/validation_widget.dart';
import '../../state/auth/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  ResetPasswordCubit() : super(ResetPasswordInitial());

  void resetPassword() {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    final passwordError = ValidationWidget.validatePassword(password);
    final confirmPasswordError = ValidationWidget.validateConfirmPassword(password, confirmPassword);

    if (passwordError != null || confirmPasswordError != null) {
      emit(ResetPasswordError(
        passwordError: passwordError,
        confirmPasswordError: confirmPasswordError,
      ));
      return;
    }

    emit(ResetPasswordSuccess());
  }

  void checkEmail() {
    final email = emailController.text;
    final emailError = ValidationWidget.validateEmail(email);

    if (emailError != null) {
      emit(EmailError(errorMsg: emailError));
    } else {
      emit(EmailSuccess());
    }
  }

  void validateField({required String field, required String value}) {
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final email = emailController.text;

    switch (field) {
      case 'email':
        final emailError = ValidationWidget.validateEmail(value);
        emit(emailError != null ? EmailError(errorMsg: emailError) : EmailSuccess());
        break;
      case 'password':
      case 'confirmPassword':
        final passwordError = ValidationWidget.validatePassword(password);
        final confirmPasswordError = ValidationWidget.validateConfirmPassword(password, confirmPassword);
        emit(ResetPasswordError(
          passwordError: passwordError,
          confirmPasswordError: confirmPasswordError,
        ));
        break;
    }
  }
}
