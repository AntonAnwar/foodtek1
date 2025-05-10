import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/cubit/auth/login_cubit.dart';
import 'package:foodtek/state/auth/login_state.dart';
import 'package:foodtek/view/screen/auth/OTP/forgot_pw_screen.dart';
import 'package:foodtek/view/screen/auth/sign_up_screen.dart';
import 'package:foodtek/view/screen/main_screens/main_page.dart';
import 'package:foodtek/view/widgets/auth/OTP/custom_auth_card.dart';
import 'package:foodtek/view/widgets/auth/OTP/reusable_scaffold.dart';
import 'package:foodtek/view/widgets/auth/custom_foodtek_logo_widget.dart';
import 'package:foodtek/view/widgets/auth/custom_social_login_button.dart';
import 'package:foodtek/view/widgets/auth/custom_text_felid_widget.dart';
import 'package:foodtek/view/widgets/auth/foodtek_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Check if there's a remembered user when the screen initializes
    context.read<LoginCubit>().checkExistingUser().then((_) {
      // If there's a remembered email, populate the email field
      // ignore: use_build_context_synchronously
      final loginCubit = context.read<LoginCubit>();
      if (loginCubit.rememberedEmail != null) {
        _emailController.text = loginCubit.rememberedEmail!;
        setState(() {
          _rememberMe = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> fieldErrors = {};
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            // Navigate to main page on successful login
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          } else if (state is LoginError) {
            fieldErrors = state.fieldErrors;
            // Show error message using SnackBar
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(state.message),
            //     backgroundColor: Colors.red,
            //   ),
            // );
          }
        },
        builder: (context, state) {
          return ReusableScaffold(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      // App Logo
                      CustomFoodtekLogoWidget(),

                      // Login Card
                      CustomAuthCard(
                        arrowIcon: false,
                        title: AppLocalizations.of(context)!.login,
                        backTo: "",
                        login: "",
                        page: "",
                        titleAlign: TextAlign.center,
                        description: AppLocalizations.of(context)!.dont_have_account,
                        descriptionAlign: TextAlign.center,
                        descriptionword: AppLocalizations.of(context)!.sign_up,
                        descriptionWordOnTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        children: [
                          // Email Field
                          CustomTextFelidWidget(
                            controller: _emailController,
                            label: AppLocalizations.of(context)!.email,
                            hintText: 'example@email.com',
                            type: TextInputType.emailAddress,
                            obscure: false,
                            errorText: fieldErrors['email']?.isNotEmpty == true ? fieldErrors['email'] : null,
                            onChange: (value) {
                              context.read<LoginCubit>().validateField(
                                field: 'email',
                                value: value,
                              );
                            },
                          ),

                          // Password Field
                          CustomTextFelidWidget(
                            controller: _passwordController,
                            label: AppLocalizations.of(context)!.password,
                            hintText: '*******',

                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey.shade600,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            type: TextInputType.text,
                            obscure: _obscurePassword,
                            errorText: fieldErrors['password']?.isNotEmpty == true ? fieldErrors['password'] : null,

                            onChange: (value) {
                              context.read<LoginCubit>().validateField(
                                field: 'password',
                                value: value,
                              );
                            },
                          ),

                          // Remember me and Forgot password
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Remember me
                              Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Checkbox(
                                      value: _rememberMe,
                                      onChanged: (value) {
                                        setState(() {
                                          _rememberMe = value!;
                                        });
                                      },
                                      activeColor: Color(0xFF38B443),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(context)!.remember_me,
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodySmall?.color,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),

                              // Forgot password
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgotPwScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.forget_password,
                                  style: TextStyle(
                                    color: Color(0xFF38B443),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Login Button
                          SizedBox(height: 24),
                          FoodtekButton(
                            text: AppLocalizations.of(context)!.login,
                            isLoading: state is LoginLoading,
                            onPressed:
                                state is LoginLoading
                                    ? null
                                    : () {
                                      // Call login function from cubit
                                      context.read<LoginCubit>().login(
                                        _emailController.text,
                                        _passwordController.text,
                                        _rememberMe,
                                      );
                                    },
                          ),

                          // Divider
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.grey[300],
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'Or',
                                  style: TextStyle(
                                    color: Theme.of(context).textTheme.bodySmall?.color,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.grey[300],
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),

                          // Social Login Buttons
                          SizedBox(height: 16),
                          CustomSocialLoginButton(
                            text: AppLocalizations.of(context)!.google,
                            iconPath: 'assets/images/auth/google.png',
                            onPressed: () {
                              // Handle Google login
                            },
                          ),

                          SizedBox(height: 12),
                          CustomSocialLoginButton(
                            text: AppLocalizations.of(context)!.facebook,
                            iconPath: 'assets/images/auth/facebook_icon.png',
                            onPressed: () {
                              // Handle Facebook login
                            },
                          ),

                          SizedBox(height: 12),
                          CustomSocialLoginButton(
                            text: AppLocalizations.of(context)!.apple,
                            iconPath: 'assets/images/auth/apple.png',
                            onPressed: () {
                              // Handle Apple login
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
