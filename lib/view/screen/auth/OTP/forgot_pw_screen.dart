import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/view/screen/auth/OTP/otp_screen.dart';
import 'package:foodtek/view/screen/auth/OTP/reset_password_screen.dart';
import '../../../../cubit/auth/reset_password_cubit.dart';
import '../../../../state/auth/reset_password_state.dart';
import '../../../widgets/auth/OTP/custom_auth_card.dart';
import '../../../widgets/auth/custom_foodtek_logo_widget.dart';
import '../../../widgets/auth/OTP/reusable_scaffold.dart';
import '../../../widgets/auth/custom_text_felid_widget.dart';
import '../../../widgets/auth/foodtek_button.dart';

class ForgotPwScreen extends StatelessWidget {
  const ForgotPwScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomFoodtekLogoWidget(),
            const SizedBox(height: 15),
            BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
              builder: (context, state) {
                final cubit = context.read<ResetPasswordCubit>();
                String? emailError;
                if (state is EmailError) {
                  emailError = state.errorMsg;
                }
                return CustomAuthCard(
                  // a custom container for the forgot and reset screens
                  arrowIcon: true,
                  backTo: 'back to ',
                  login: "login ",
                  page: "page",
                  title: "Reset Password",
                  description:
                      "Enter your email or phone number and we'll\n send you a link to reset your password.",
                  descriptionword: "",

                  titleAlign: TextAlign.center,
                  descriptionAlign: TextAlign.center,
                  children: [
                    CustomTextFelidWidget(
                      controller: cubit.emailController,
                      label: "Email",
                      hintText: "example@email.com",
                      type: TextInputType.emailAddress,
                      obscure: false,
                      errorText: emailError,
                    ),
                    const SizedBox(height: 24),
                    FoodtekButton(
                      text: "Send",
                      onPressed: () {
                        cubit.checkEmail();
                        if (cubit.state is EmailSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => OtpScreen(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  ResetPasswordScreen(),
                                        ),
                                      );
                                    },
                                  ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
