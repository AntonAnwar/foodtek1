import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/state/auth/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  // Property to store remembered email
  String? rememberedEmail;
  Future<void> login(String email, String password, bool rememberMe) async {
    Map<String, String> errors = {};

    // Email validation
    if (email.isEmpty) {
      errors['email'] = 'Email is required';
    } else {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        errors['email'] = 'Enter a valid email';
      }
    }

    // Password validation
    if (password.isEmpty) {
      errors['password'] = 'Password is required';
    } else {
      final passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
      if (!passwordRegex.hasMatch(password)) {
        errors['password'] =
        'Password must be at least 8 characters,\n include upper & lowercase letters, a number, and a special character';
      }
    }

    // Emit errors if found
    if (errors.isNotEmpty) {
      emit(LoginError('Please correct the errors below', fieldErrors: errors));
      return;
    }

    try {
      emit(LoginLoading());

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

  // this method is to validateField individually as the user types
  void validateField({required String field, required String value}) {
    final currentErrors = Map<String, String>.from(
      state is LoginError ? (state as LoginError).fieldErrors : {},
    );

    if (field == 'email') {
      if (value.isEmpty) {
        currentErrors['email'] = 'Email is required';
      } else {
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          currentErrors['email'] = 'Enter a valid email';
        } else {
          currentErrors.remove('email');
        }
      }
    }

    if (field == 'password') {
      if (value.isEmpty) {
        currentErrors['password'] = 'Password is required';
      } else {
        final passwordRegex = RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
        if (!passwordRegex.hasMatch(value)) {
          currentErrors['password'] =
          'Password must be at least 8 characters,\ninclude upper & lowercase letters, a number, and a special character';
        } else {
          currentErrors.remove('password');
        }
      }
    }

    emit(LoginError('Please correct the errors below', fieldErrors: currentErrors));
  }


  // // Login with email and password
  // Future<void> login(String email, String password, bool rememberMe) async {
  //   // Check for empty fields
  //   if (email.isEmpty || password.isEmpty) {
  //     emit(LoginError('Please fill in all fields'));
  //     return;
  //   }
  //
  //   // Validate email format
  //   final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  //   if (!emailRegex.hasMatch(email)) {
  //     emit(LoginError('Please enter a valid email address'));
  //     return;
  //   }
  //
  //   try {
  //     emit(LoginLoading());
  //
  //     // Here you would typically make an API call to authenticate
  //     // For demo purposes, we'll simulate a successful login after a delay
  //     await Future.delayed(const Duration(seconds: 2));
  //
  //     // Save remember me preference if selected
  //     if (rememberMe) {
  //       final prefs = await SharedPreferences.getInstance();
  //       await prefs.setBool('rememberMe', true);
  //       await prefs.setString('userEmail', email);
  //     } else {
  //       // If not remember me, clear any previous saved data
  //       final prefs = await SharedPreferences.getInstance();
  //       await prefs.remove('rememberMe');
  //       await prefs.remove('userEmail');
  //     }
  //
  //     emit(LoginSuccess());
  //   } catch (e) {
  //     String errorMessage;
  //     final errorCode = e.toString();
  //
  //     switch (errorCode) {
  //       case 'user-not-found':
  //         errorMessage = 'No user found with this email address';
  //         break;
  //       case 'wrong-password':
  //         errorMessage = 'Invalid password, please try again';
  //         break;
  //       case 'invalid-email':
  //         errorMessage = 'Please enter a valid email address';
  //         break;
  //       case 'user-disabled':
  //         errorMessage = 'This account has been disabled';
  //         break;
  //       case 'too-many-requests':
  //         errorMessage =
  //             'Too many failed login attempts. Please try again later';
  //         break;
  //       default:
  //         errorMessage = 'An error occurred during login. Please try again';
  //     }
  //
  //     emit(LoginError(errorMessage));
  //   }
  // }

  // Check for existing remembered user
  Future<void> checkExistingUser() async {
    try {
      // Check for remember me data
      final prefs = await SharedPreferences.getInstance();
      final rememberMe = prefs.getBool('rememberMe') ?? false;

      if (rememberMe) {
        final userEmail = prefs.getString('userEmail');
        if (userEmail != null && userEmail.isNotEmpty) {
          // Store the email for auto-fill
          rememberedEmail = userEmail;
        }
      }

      emit(LoginInitial());
    } catch (e) {
      emit(LoginInitial());
    }
  }
}
