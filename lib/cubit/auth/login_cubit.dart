import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodtek/state/auth/login_state.dart';
import '../../core/validation_widget.dart'; // Import this file

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  String? rememberedEmail;

  Future<void> login(String email, String password, bool rememberMe) async {
    emit(LoginLoading());

    String? emailError = ValidationWidget.validateEmail(email);
    String? passwordError = ValidationWidget.validatePassword(password);

    if (emailError != null || passwordError != null) {
      emit(LoginError(
        'Please correct the errors below',
        fieldErrors: {
          if (emailError != null) 'email': emailError,
          if (passwordError != null) 'password': passwordError,
        },
      ));
      return;
    }

    try {
      await Future.delayed(const Duration(seconds: 2));
      final prefs = await SharedPreferences.getInstance();

      if (rememberMe) {
        await prefs.setBool('rememberMe', true);
        await prefs.setString('userEmail', email);
      } else {
        await prefs.remove('rememberMe');
        await prefs.remove('userEmail');
      }

      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError('An error occurred during login'));
    }
  }

  // Realtime validation while typing
  void validateField({required String field, required String value}) {
    final currentErrors = Map<String, String>.from(
      state is LoginError ? (state as LoginError).fieldErrors : {},
    );

    if (field == 'email') {
      String? error = ValidationWidget.validateEmail(value);
      if (error != null) {
        currentErrors['email'] = error;
      } else {
        currentErrors.remove('email');
      }
    }

    if (field == 'password') {
      String? error = ValidationWidget.validatePassword(value);
      if (error != null) {
        currentErrors['password'] = error;
      } else {
        currentErrors.remove('password');
      }
    }

    emit(LoginError('Please correct the errors below', fieldErrors: currentErrors));
  }

  Future<void> checkExistingUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rememberMe = prefs.getBool('rememberMe') ?? false;

      if (rememberMe) {
        final userEmail = prefs.getString('userEmail');
        if (userEmail != null && userEmail.isNotEmpty) {
          rememberedEmail = userEmail;
        }
      }

      emit(LoginInitial());
    } catch (e) {
      emit(LoginInitial());
    }
  }
}




// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:foodtek/state/auth/login_state.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginInitial());
//
//   // Property to store remembered email
//   String? rememberedEmail;
//   Future<void> login(String email, String password, bool rememberMe) async {
//     Map<String, String> errors = {};
//
//     // Email validation
//     if (email.isEmpty) {
//       errors['email'] = 'Email is required';
//     } else {
//       final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//       if (!emailRegex.hasMatch(email)) {
//         errors['email'] = 'Enter a valid email';
//       }
//     }
//
//     // Password validation
//     if (password.isEmpty) {
//       errors['password'] = 'Password is required';
//     } else {
//       final passwordRegex =
//       RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
//       if (!passwordRegex.hasMatch(password)) {
//         errors['password'] =
//         'Password must be at least 8 characters,\n include upper & lowercase letters, a number, and a special character';
//       }
//     }
//
//     // Emit errors if found
//     if (errors.isNotEmpty) {
//       emit(LoginError('Please correct the errors below', fieldErrors: errors));
//       return;
//     }
//
//     try {
//       emit(LoginLoading());
//
//       await Future.delayed(const Duration(seconds: 2));
//
//       final prefs = await SharedPreferences.getInstance();
//
//       if (rememberMe) {
//         await prefs.setBool('rememberMe', true);
//         await prefs.setString('userEmail', email);
//       } else {
//         await prefs.remove('rememberMe');
//         await prefs.remove('userEmail');
//       }
//
//       emit(LoginSuccess());
//     } catch (e) {
//       emit(LoginError('An error occurred during login'));
//     }
//   }
//
//   // this method is to validateField individually as the user types
//   void validateField({required String field, required String value}) {
//     final currentErrors = Map<String, String>.from(
//       state is LoginError ? (state as LoginError).fieldErrors : {},
//     );
//
//     if (field == 'email') {
//       if (value.isEmpty) {
//         currentErrors['email'] = 'Email is required';
//       } else {
//         final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
//         if (!emailRegex.hasMatch(value)) {
//           currentErrors['email'] = 'Enter a valid email';
//         } else {
//           currentErrors.remove('email');
//         }
//       }
//     }
//
//     if (field == 'password') {
//       if (value.isEmpty) {
//         currentErrors['password'] = 'Password is required';
//       } else {
//         final passwordRegex = RegExp(
//             r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
//         if (!passwordRegex.hasMatch(value)) {
//           currentErrors['password'] =
//           'Password must be at least 8 characters,\ninclude upper & lowercase letters, a number, and a special character';
//         } else {
//           currentErrors.remove('password');
//         }
//       }
//     }
//
//     emit(LoginError('Please correct the errors below', fieldErrors: currentErrors));
//   }
//   Future<void> checkExistingUser() async {
//     try {
//       // Check for remember me data
//       final prefs = await SharedPreferences.getInstance();
//       final rememberMe = prefs.getBool('rememberMe') ?? false;
//
//       if (rememberMe) {
//         final userEmail = prefs.getString('userEmail');
//         if (userEmail != null && userEmail.isNotEmpty) {
//           // Store the email for auto-fill
//           rememberedEmail = userEmail;
//         }
//       }
//
//       emit(LoginInitial());
//     } catch (e) {
//       emit(LoginInitial());
//     }
//   }
//
//
//
// }