class ValidationWidget {
  static String? validateEmail(String email) {
    final emailRegex =
    RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if (email.isEmpty) {
      return "Please enter your email";
    } else if (!emailRegex.hasMatch(email)) {
      return "Invalid email format";
    }
    return null; // No error
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return "Please enter your password";
    } else if (password.length < 8) {
      return "Password must be at least 8 characters long";
    } else if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return "Password must contain at least one uppercase letter";
    } else if (!RegExp(r'[a-z]').hasMatch(password)) {
      return "Password must contain at least one lowercase letter";
    } else if (!RegExp(r'\d').hasMatch(password)) {
      return "Password must contain at least one number";
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
      return "Password must contain at least one special character";
    } else if (password.contains(' ')) {
      return "Password must not contain spaces";
    }
    return null; // No error
  }

  static String? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return "Confirm Password cannot be empty";
    if (password != confirmPassword) return "Passwords do not match!";
    return null;
  }

  static String? validateName(String name) {
    if (name.isEmpty) return "Please enter your full name";
    if (name.length > 40) return "Name cannot be longer than 40 characters";
    return null;
  }

  static String? validateDate(String date) {
    final dateRegex =
    RegExp(r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}$');
    if (date.isEmpty) return "Please enter your birth date";
    if (!dateRegex.hasMatch(date)) return "Invalid date format (DD/MM/YYYY)";
    return null;
  }

  static String? validatePhone(String phone) {
    final phoneRegex = RegExp(r'^\+?\d{9,}$');
    if (phone.isEmpty) return "Please enter your phone number";
    if (!phoneRegex.hasMatch(phone)) return "Invalid phone number";
    return null;
  }


}