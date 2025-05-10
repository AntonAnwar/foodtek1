import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/theme_cubit.dart';

class ThemeSelectorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final currentMode = themeCubit.state;

    return Container(
        height: 175,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            RadioListTile<ThemeMode>(
              title: Text('Light Mode'),
              value: ThemeMode.light,
              groupValue: currentMode,
              onChanged: (_) => themeCubit.setLightMode(),
            ),
            RadioListTile<ThemeMode>(
              title: Text('Dark Mode'),
              value: ThemeMode.dark,
              groupValue: currentMode,
              onChanged: (_) => themeCubit.setDarkMode(),
            ),
            RadioListTile<ThemeMode>(
              title: Text('System Default'),
              value: ThemeMode.system,
              groupValue: currentMode,
              onChanged: (_) => themeCubit.setSystemMode(),
            ),
          ],
        ),
      );

  }
}
