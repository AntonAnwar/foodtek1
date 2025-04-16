import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodtek/constant/colors.dart';

import '../../../cubit/lang_cubit.dart';

class LanguageSelectorSheet extends StatelessWidget {
  const LanguageSelectorSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final currentLang = context.read<LangCubit>().state.languageCode;

    return Container(
      height: 175,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              activeColor: AppColors.primaryColor,
              title: Text('English'),
              value: 'en',
              groupValue: currentLang,
              onChanged: (value) {
                context.read<LangCubit>().changeLang(value!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              activeColor: AppColors.primaryColor,
              title: Text('العربية'),
              value: 'ar',
              groupValue: currentLang,
              onChanged: (value) {
                context.read<LangCubit>().changeLang(value!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
