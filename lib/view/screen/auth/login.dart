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
            // Show error message using SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
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
                        title: "Login",
                        backTo: "",
                        login: "",
                        page: "",
                        titleAlign: TextAlign.center,
                        description: "Don't have an account?",
                        descriptionAlign: TextAlign.center,
                        descriptionword: " Sign Up",
                        descriptionWordOnTap: () {
                          Navigator.pushReplacement(
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
                            label: "Email",
                            hintText: 'example@email.com',
                            type: TextInputType.emailAddress,
                            obscure: false,
                          ),

                          // Password Field
                          CustomTextFelidWidget(
                            controller: _passwordController,
                            label: "Password",
                            hintText: '*******',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            type: TextInputType.text,
                            obscure: _obscurePassword,
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
                                    'Remember me',
                                    style: TextStyle(
                                      color: Colors.grey[700],
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
                                  'Forgot Password ?',
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
                            text: "Login",
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
                                    color: Colors.grey[600],
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
                            text: 'Continue with Google',
                            iconPath: 'assets/images/auth/google.png',
                            onPressed: () {
                              // Handle Google login
                            },
                          ),

                          SizedBox(height: 12),
                          CustomSocialLoginButton(
                            text: 'Continue with Facebook',
                            iconPath: 'assets/images/auth/facebook_icon.png',
                            onPressed: () {
                              // Handle Facebook login
                            },
                          ),

                          SizedBox(height: 12),
                          CustomSocialLoginButton(
                            text: 'Continue with Apple',
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
