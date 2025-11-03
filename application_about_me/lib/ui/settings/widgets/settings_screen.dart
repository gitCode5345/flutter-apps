import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application_about_me/ui/settings/view_model/theme_view_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Налаштування'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          DropdownMenu<ThemeMode>(
            initialSelection: themeViewModel.themeMode,
            label: const Text('Оформлення'),
            expandedInsets: EdgeInsets.zero, 
            onSelected: (ThemeMode? newValue) {
              if (newValue != null) {
                themeViewModel.setTheme(newValue);
              }
            },

            dropdownMenuEntries: const [
              DropdownMenuEntry(
                value: ThemeMode.light,
                label: 'Світла тема',
                leadingIcon: Icon(Icons.light_mode_outlined),
              ),
              DropdownMenuEntry(
                value: ThemeMode.dark,
                label: 'Темна тема',
                leadingIcon: Icon(Icons.dark_mode_outlined),
              ),
              DropdownMenuEntry(
                value: ThemeMode.system,
                label: 'Як у системі',
                leadingIcon: Icon(Icons.settings_system_daydream_outlined),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
