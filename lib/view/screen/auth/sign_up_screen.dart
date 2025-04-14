import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/cubit/auth/sign_up_cubit.dart';
import 'package:foodtek/state/auth/sign_up_state.dart';
import 'package:foodtek/view/screen/auth/OTP/otp_screen.dart';
import 'package:foodtek/view/screen/auth/login.dart';
import 'package:foodtek/view/widgets/auth/OTP/custom_auth_card.dart';
import 'package:foodtek/view/widgets/auth/OTP/reusable_scaffold.dart';
import 'package:foodtek/view/widgets/auth/custom_foodtek_logo_widget.dart';
import 'package:foodtek/view/widgets/auth/custom_text_felid_widget.dart';
import 'package:foodtek/view/widgets/auth/foodtek_button.dart';

class SignUpScreen extends StatelessWidget {
  final GlobalKey<FormState> formkey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpCubit = context.read<SignUpCubit>();

    return ReusableScaffold(
      child: SingleChildScrollView(
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              // إذا تم التحقق من النموذج بنجاح، انتقل إلى شاشة OTP

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => OtpScreen(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      ),
                ),
              );
            }
            // يمكنك إضافة معالجة أخرى هنا مثل عرض snackbar في حالة الخطأ
          },
          builder: (context, state) {
            // استخراج رسائل الخطأ من الحالة
            Map<String, String> fieldErrors = {};
            if (state is SignUpValidationError ||
                state is SignUpFieldValidation) {
              fieldErrors =
                  (state is SignUpValidationError)
                      ? (state).fieldErrors
                      : (state as SignUpFieldValidation).fieldErrors;
            }

            // التحقق من حالة رؤية كلمة المرور
            bool obscurePassword = true;
            if (state is SignUpPasswordVisibilityChanged) {
              obscurePassword = (state).isVisible;
            } else {
              obscurePassword = signUpCubit.obscureText;
            }

            return Column(
              children: [
                CustomFoodtekLogoWidget(),
                CustomAuthCard(
                  arrowIcon: true,
                  title: "sign up",
                  backTo: "",
                  login: "",
                  page: "",
                  titleAlign: TextAlign.start,
                  description: "Already have an account ? ",
                  descriptionword: "Login",
                  descriptionWordOnTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  descriptionAlign: TextAlign.start,
                  children: [
                    Form(
                      key: formkey,
                      child: Column(
                        children: [
                          // حقل الاسم الكامل
                          CustomTextFelidWidget(
                            controller: nameController,
                            label: "Full Name",
                            hintText: "Your Name",
                            type: TextInputType.text,
                            obscure: false,
                            validator: (value) {
                              signUpCubit.validateField(
                                field: 'name',
                                value: value ?? "",
                              );
                              return null;
                            },
                            errorText: fieldErrors['name'] ?? "",
                          ),

                          // حقل البريد الإلكتروني
                          CustomTextFelidWidget(
                            controller: emailController,
                            label: "Email",
                            hintText: "example@email.com",
                            type: TextInputType.emailAddress,
                            obscure: false,
                            validator: (value) {
                              signUpCubit.validateField(
                                field: 'email',
                                value: value ?? "",
                              );
                              return null;
                            },
                            errorText: fieldErrors['email'] ?? "",
                          ),

                          // حقل تاريخ الميلاد
                          CustomTextFelidWidget(
                            controller: dateController,
                            label: "Birth of date",
                            hintText: "DD/MM/YYYY",
                            type: TextInputType.datetime,
                            obscure: false,
                            validator: (value) {
                              signUpCubit.validateField(
                                field: 'date',
                                value: value ?? "",
                              );
                              return null;
                            },
                            errorText: fieldErrors['date'] ?? "",
                          ),

                          // حقل رقم الهاتف
                          CustomTextFelidWidget(
                            controller: phoneController,
                            label: "Phone",
                            hintText: "0770000000",
                            type: TextInputType.number,
                            obscure: false,
                            validator: (value) {
                              signUpCubit.validateField(
                                field: 'phone',
                                value: value ?? "",
                              );
                              return null;
                            },
                            errorText: fieldErrors['phone'] ?? "",
                          ),

                          // حقل كلمة المرور
                          CustomTextFelidWidget(
                            controller: passwordController,
                            label: "Set Password",
                            hintText: '*******',
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                signUpCubit.togglePasswordVisibility();
                              },
                            ),
                            type: TextInputType.text,
                            obscure: obscurePassword,
                            validator: (value) {
                              signUpCubit.validateField(
                                field: 'password',
                                value: value ?? "",
                              );
                              return null;
                            },
                            errorText: fieldErrors['password'] ?? "",
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    FoodtekButton(
                      text:
                          state is SignUpLoading ? "Processing..." : "Register",
                      onPressed:
                          state is SignUpLoading
                              ? null // تعطيل الزر أثناء التحميل
                              : () {
                                // إعادة التحقق من جميع الحقول مرة واحدة
                                signUpCubit.registerUser(
                                  name: nameController.text,
                                  email: emailController.text,
                                  date: dateController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text,
                                );
                              },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
