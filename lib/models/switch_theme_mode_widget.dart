import 'package:aleman_stations/theme/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchThemeModeWidget extends StatelessWidget {
  const SwitchThemeModeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Consumer<ThemeProvider>(builder: ((context, themeProvider, child) {
      return Switch.adaptive(
        value: themeProvider.isDarkMode,
        onChanged: (value) => themeProvider.switchDarkMode(value),
      );
    }));
  }
}
