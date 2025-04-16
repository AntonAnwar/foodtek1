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
import 'package:date_format_field/date_format_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                  title: AppLocalizations.of(context)!.sign_up,
                  backTo: "",
                  login: "",
                  page: "",
                  titleAlign: TextAlign.start,
                  description: AppLocalizations.of(context)!.have_account,
                  descriptionword: AppLocalizations.of(context)!.login,
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
                            label: AppLocalizations.of(context)!.full_name,
                            hintText: AppLocalizations.of(context)!.enter_full_name,
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
                            onChange: (value) {
                              signUpCubit.validateField(
                                field: 'name',
                                value: value ?? "",
                              );
                            },
                          ),

                          // حقل البريد الإلكتروني
                          CustomTextFelidWidget(
                            controller: emailController,
                            label: AppLocalizations.of(context)!.email,
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
                            onChange: (value) {
                              signUpCubit.validateField(
                                field: 'email',
                                value: value ?? "",
                              );
                            },
                          ),

                          // حقل تاريخ الميلاد
                          // CustomTextFelidWidget(
                          //   controller: dateController,
                          //   label: "Birth of date",
                          //   hintText: "DD/MM/YYYY",
                          //   type: TextInputType.datetime,
                          //   obscure: false,
                          //   validator: (value) {
                          //     signUpCubit.validateField(
                          //       field: 'date',
                          //       value: value ?? "",
                          //     );
                          //     return null;
                          //   },
                          //   errorText: fieldErrors['date'] ?? "",
                          // ),
                          Container(
                            // margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context)!.birthdate),
                                SizedBox(height: 8),
                                DateFormatField(
                                  controller: dateController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    hintText: '18/03/2024',
                                    errorText: fieldErrors['date'],
                                    // 🛑 Show error if exists
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Color(0xFF38B443),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  type: DateFormatType.type1,
                                  onComplete: (date) {
                                    dateController.text =
                                        "${date?.day.toString().padLeft(2, '0')}/"
                                        "${date?.month.toString().padLeft(2, '0')}/"
                                        "${date?.year}";
                                    signUpCubit.validateField(
                                      field: 'date',
                                      value: dateController.text,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),

                          // حقل رقم الهاتف
                          // CustomTextFelidWidget(
                          //   controller: phoneController,
                          //   label: "Phone",
                          //   hintText: "0770000000",
                          //   type: TextInputType.number,
                          //   obscure: false,
                          //   validator: (value) {
                          //     signUpCubit.validateField(
                          //       field: 'phone',
                          //       value: value ?? "",
                          //     );
                          //     return null;
                          //   },
                          //   errorText: fieldErrors['phone'] ?? "",
                          // ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(AppLocalizations.of(context)!.phone_number),
                                SizedBox(height: 8),
                                IntlPhoneField(
                                  controller: phoneController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    labelText: AppLocalizations.of(context)!.enter_phone,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Colors.grey[300]!,
                                        width: 1,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                        color: Color(0xFF38B443),
                                        width: 1,
                                      ),
                                    ),
                                    errorText: fieldErrors['phone'],
                                  ),
                                  initialCountryCode: 'JO',
                                  // Or whatever default you'd like
                                  onChanged: (phone) {
                                    signUpCubit.validateField(
                                      field: 'phone',
                                      value: phone.completeNumber,
                                    );
                                  },
                                  onCountryChanged: (country) {
                                    // Optional: do something when the country changes
                                  },
                                ),
                              ],
                            ),
                          ),

                          // حقل كلمة المرور
                          CustomTextFelidWidget(
                            controller: passwordController,
                            label: AppLocalizations.of(context)!.set_password,
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
                            onChange: (value) {
                              signUpCubit.validateField(
                                field: 'password',
                                value: value ?? "",
                              );
                            },
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
