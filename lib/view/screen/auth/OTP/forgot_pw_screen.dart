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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                  backTo: AppLocalizations.of(context)!.back_to,
                  login: AppLocalizations.of(context)!.login,
                  page: AppLocalizations.of(context)!.page,
                  title: AppLocalizations.of(context)!.rest_password,
                  description:
                  AppLocalizations.of(context)!.enter_your_email,
                  descriptionword: "",

                  titleAlign: TextAlign.center,
                  descriptionAlign: TextAlign.center,
                  children: [
                    CustomTextFelidWidget(
                      controller: cubit.emailController,
                      label: AppLocalizations.of(context)!.email,
                      hintText: "example@email.com",
                      type: TextInputType.emailAddress,
                      obscure: false,
                      errorText: emailError,
                      onChange: (value) {
                        cubit.validateField(field: 'email', value: value);
                      },
                    ),
                    const SizedBox(height: 24),
                    FoodtekButton(
                      text: AppLocalizations.of(context)!.send,
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
