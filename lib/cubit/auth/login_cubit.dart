import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/state/auth/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  // Property to store remembered email
  String? rememberedEmail;

  // Login with email and password
  Future<void> login(String email, String password, bool rememberMe) async {
    // Check for empty fields
    if (email.isEmpty || password.isEmpty) {
      emit(LoginError('Please fill in all fields'));
      return;
    }

    // Validate email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      emit(LoginError('Please enter a valid email address'));
      return;
    }

    try {
      emit(LoginLoading());

      // Here you would typically make an API call to authenticate
      // For demo purposes, we'll simulate a successful login after a delay
      await Future.delayed(const Duration(seconds: 2));

      // Save remember me preference if selected
      if (rememberMe) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('rememberMe', true);
        await prefs.setString('userEmail', email);
      } else {
        // If not remember me, clear any previous saved data
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('rememberMe');
        await prefs.remove('userEmail');
      }

      emit(LoginSuccess());
    } catch (e) {
      String errorMessage;
      final errorCode = e.toString();

      switch (errorCode) {
        case 'user-not-found':
          errorMessage = 'No user found with this email address';
          break;
        case 'wrong-password':
          errorMessage = 'Invalid password, please try again';
          break;
        case 'invalid-email':
          errorMessage = 'Please enter a valid email address';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled';
          break;
        case 'too-many-requests':
          errorMessage =
              'Too many failed login attempts. Please try again later';
          break;
        default:
          errorMessage = 'An error occurred during login. Please try again';
      }

      emit(LoginError(errorMessage));
    }
  }

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
