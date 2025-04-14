  // bool isEmailText = true;
  // bool isPassword = true;
  // bool obscureText = true;
  // bool isEmpty = false;
  // bool isLong = false;
  // checkEmpty({required String val}) {
  //   isEmpty = val.isEmpty;
  //   notifyListeners();
  //   return isEmpty;
  // }

  //   checkLength({required String val}) {
  //   isLong = val.length > 40;

  //   notifyListeners();
  //   return isLong;
  // }

  // bool isEmail({required String email}) {
  //   String p =
  //       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  //   RegExp regExp = RegExp(p);
  //   isEmailText = regExp.hasMatch(email);
  //   return regExp.hasMatch(email);
  // }
  // bool isStrongPassword({required String password}) {
  //   String pattern =
  //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  //   RegExp regExp = RegExp(pattern);
  //   return regExp.hasMatch(password);
  // }

  // //Make Sure Same Password (confirm Password)
  // bool isSamePassword(String pass1, String pass2) {
  //   return pass1 == pass2;
  // }

  // checkPassword({required String password}) {
  //   isPassword = password.isNotEmpty;
  //   notifyListeners();
  // }

  // changeOpscureTextPassword() {
  //   obscureText = !obscureText;
  //   notifyListeners();
  // }