// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/view/screen/auth/login.dart';
import 'package:foodtek/view/widgets/auth/OTP/custom_auth_card.dart';
import 'package:foodtek/view/widgets/auth/OTP/reusable_scaffold.dart';
import '../../../../cubit/auth/reset_password_cubit.dart';
import '../../../../core/responseve.dart';
import '../../../../state/auth/reset_password_state.dart';
import '../../../widgets/auth/custom_foodtek_logo_widget.dart';
import '../../../widgets/auth/custom_text_felid_widget.dart';
import '../../../widgets/auth/foodtek_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: ResetPasswordView(),
    );
  }
}

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/auth/reset_password_success.png",
                      height: responsiveHeight(context, 287),
                      width: responsiveWidth(context, 430.5),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Congratulations!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Password reset successfully",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          );

          // Delay navigation to login screen after 2 seconds
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pop(context); // Close the dialog
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          });
        }
      },
      child: ReusableScaffold(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomFoodtekLogoWidget(),
              const SizedBox(height: 15),
              BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                builder: (context, state) {
                  final cubit = context.read<ResetPasswordCubit>();
                  String? passwordError;
                  String? confirmPasswordError;

                  if (state is ResetPasswordError) {
                    passwordError = state.passwordError;
                    confirmPasswordError = state.confirmPasswordError;
                  }

                  return CustomAuthCard(
                    title: AppLocalizations.of(context)!.rest_password,
                    titleAlign: TextAlign.start,
                    description:
                        AppLocalizations.of(context)!.want_current_password,
                    descriptionAlign: TextAlign.start,
                    backTo: '',
                    login: '',
                    page: '',
                    descriptionword: AppLocalizations.of(context)!.login,
                    // this was the problem
                    descriptionWordOnTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    // or this
                    arrowIcon: true,
                    children: [
                      Column(
                        children: [
                          CustomTextFelidWidget(
                            controller: cubit.passwordController,
                            label: AppLocalizations.of(context)!.new_password,
                            hintText: '********',
                            type: TextInputType.visiblePassword,
                            obscure: true,
                            errorText:
                                state is ResetPasswordError
                                    ? state.passwordError
                                    : null,
                            onChange: (value) {
                              cubit.validateField(
                                field: 'password',
                                value: value,
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          CustomTextFelidWidget(
                            controller: cubit.confirmPasswordController,
                            label:
                                AppLocalizations.of(
                                  context,
                                )!.confirm_new_password,
                            hintText: '********',
                            type: TextInputType.visiblePassword,
                            obscure: true,
                            errorText:
                                state is ResetPasswordError
                                    ? state.confirmPasswordError
                                    : null,
                            onChange: (value) {
                              cubit.validateField(
                                field: 'confirmPassword',
                                value: value,
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                          FoodtekButton(
                            text: AppLocalizations.of(context)!.update_password,
                            onPressed: () {
                              cubit.resetPassword();
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
