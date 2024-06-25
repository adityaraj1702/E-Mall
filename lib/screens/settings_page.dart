import 'package:e_mall/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          RadioListTile<AppTheme>(
            title: const Text('Light Theme'),
            value: AppTheme.light,
            groupValue: themeProvider.appTheme,
            onChanged: (value) {
              if (value != null) themeProvider.setTheme(value);
            },
          ),
          RadioListTile<AppTheme>(
            title: const Text('Dark Theme'),
            value: AppTheme.dark,
            groupValue: themeProvider.appTheme,
            onChanged: (value) {
              if (value != null) themeProvider.setTheme(value);
            },
          ),
          RadioListTile<AppTheme>(
            title: const Text('System Theme'),
            value: AppTheme.system,
            groupValue: themeProvider.appTheme,
            onChanged: (value) {
              if (value != null) themeProvider.setTheme(value);
            },
          ),
        ],
      ),
    );
  }
}
