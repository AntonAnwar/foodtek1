import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/state/auth/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  bool obscureText = true;

  // خريطة لتخزين رسائل الخطأ لكل حقل
  Map<String, String> fieldErrors = {
    'name': '',
    'email': '',
    'date': '',
    'phone': '',
    'password': '',
  };

  SignUpCubit() : super(SignUpInitial());

  // تحقق من صحة النموذج بالكامل
  bool validateForm({
    required String name,
    required String email,
    required String date,
    required String phone,
    required String password,
  }) {
    bool isValid = true;

    // إعادة تعيين جميع رسائل الخطأ
    fieldErrors = {
      'name': '',
      'email': '',
      'date': '',
      'phone': '',
      'password': '',
    };

    // التحقق من الاسم
    if (name.isEmpty) {
      fieldErrors['name'] = "Please enter your full name";
      isValid = false;
    } else if (name.length > 40) {
      fieldErrors['name'] = "Name cannot be longer than 40 characters";
      isValid = false;
    }

    // التحقق من البريد الإلكتروني
    if (email.isEmpty) {
      fieldErrors['email'] = "Please enter your email";
      isValid = false;
    } else if (!_isValidEmail(email)) {
      fieldErrors['email'] = "Invalid email format";
      isValid = false;
    }

    // التحقق من تاريخ الميلاد
    if (date.isEmpty) {
      fieldErrors['date'] = "Please enter your birth date";
      isValid = false;
    } else if (!_isValidDate(date)) {
      fieldErrors['date'] = "Invalid date format (DD/MM/YYYY)";
      isValid = false;
    }

    // التحقق من رقم الهاتف
    if (phone.isEmpty) {
      fieldErrors['phone'] = "Please enter your phone number";
      isValid = false;
    } else if (!_isValidPhone(phone)) {
      fieldErrors['phone'] = "Invalid phone number";
      isValid = false;
    }

    // التحقق من كلمة المرور
    if (password.isEmpty) {
      fieldErrors['password'] = "Please enter a password";
      isValid = false;
    } else if (!_isStrongPassword(password)) {
      fieldErrors['password'] =
          "Password must be at least 8 characters with uppercase, lowercase, numbers, and special characters";
      isValid = false;
    }

    // إصدار حالة جديدة بناءً على نتيجة التحقق
    if (isValid) {
      emit(SignUpSuccess());
    } else {
      emit(SignUpValidationError(fieldErrors));
    }

    return isValid;
  }

  // تحقق فردي لكل حقل
  void validateField({required String field, required String value}) {
    switch (field) {
      case 'name':
        if (value.isEmpty) {
          fieldErrors['name'] = "Please enter your full name";
        } else if (value.length > 40) {
          fieldErrors['name'] = "Name cannot be longer than 40 characters";
        } else {
          fieldErrors['name'] = '';
        }
        break;
      case 'email':
        if (value.isEmpty) {
          fieldErrors['email'] = "Please enter your email";
        } else if (!_isValidEmail(value)) {
          fieldErrors['email'] = "Invalid email format";
        } else {
          fieldErrors['email'] = '';
        }
        break;
      case 'date':
        if (value.isEmpty) {
          fieldErrors['date'] = "Please enter your birth date";
        } else if (!_isValidDate(value)) {
          fieldErrors['date'] = "Invalid date format (DD/MM/YYYY)";
        } else {
          fieldErrors['date'] = '';
        }
        break;
      case 'phone':
        if (value.isEmpty) {
          fieldErrors['phone'] = "Please enter your phone number";
        } else if (!_isValidPhone(value)) {
          fieldErrors['phone'] = "Invalid phone number";
        } else {
          fieldErrors['phone'] = '';
        }
        break;
      case 'password':
        if (value.isEmpty) {
          fieldErrors['password'] = "Please enter a password";
        } else if (!_isStrongPassword(value)) {
          fieldErrors['password'] =
              "Password must be at least 8 characters with uppercase, lowercase, numbers, and special characters";
        } else {
          fieldErrors['password'] = '';
        }
        break;
    }

    emit(SignUpFieldValidation(fieldErrors));
  }

  // تبديل إظهار/إخفاء كلمة المرور
  void togglePasswordVisibility() {
    obscureText = !obscureText;
    emit(SignUpPasswordVisibilityChanged(obscureText));
  }

  // تسجيل المستخدم
  Future<void> registerUser({
    required String name,
    required String email,
    required String date,
    required String phone,
    required String password,
  }) async {
    // قبل إرسال البيانات، تحقق من صحة النموذج
    if (!validateForm(
      name: name,
      email: email,
      date: date,
      phone: phone,
      password: password,
    )) {
      return;
    }

    // بدء عملية التسجيل
    emit(SignUpLoading());

    try {
      // هنا يمكنك إضافة منطق الاتصال بالخادم أو Firebase أو أي خدمة أخرى
      // await authService.signUp(name, email, date, phone, password);

      // في حالة نجاح التسجيل
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpError("Registration failed: ${e.toString()}"));
    }
  }

  // دوال مساعدة للتحقق
  bool _isValidEmail(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  bool _isStrongPassword(String password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  bool _isValidDate(String date) {
    // تحقق بسيط من تنسيق التاريخ DD/MM/YYYY
    String pattern = r'^(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[0-2])\/\d{4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(date);
  }

  bool _isValidPhone(String phone) {
    // تحقق بسيط من رقم الهاتف (يمكن تخصيصه حسب تنسيق الأرقام في بلدك)
    String pattern = r'^\d{10,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(phone);
  }
}
