import 'package:finance/cubit/SettingsCubit.dart';
import 'package:finance/views/login_view.dart';
import 'package:finance/widgets/About_Widget.dart';
import 'package:finance/widgets/backup_Widget.dart';
import 'package:finance/widgets/currency_Widget.dart';
import 'package:finance/widgets/profile_Widget.dart';
import 'package:flutter/material.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({
    super.key,
    required this.currencies,
    required this.cubit,
    required this.state,
  });

  final List<String> currencies;
  final SettingsCubit cubit;
  final SettingsState state;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        profileWidget(),

        currencyWidget(currencies: currencies, cubit: cubit, state: state),

        SwitchListTile(
          title: const Text("Dark Mode"),

          secondary: const Icon(Icons.dark_mode),

          value: state.settings.darkMode,

          onChanged: cubit.changeDarkMode,
        ),

        SwitchListTile(
          title: const Text("Notifications"),

          secondary: const Icon(Icons.notifications),

          value: state.settings.notifications,

          onChanged: cubit.changeNotification,
        ),

        backupWidget(),

        AboutWidget(),

        const SizedBox(height: 30),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginView.id,
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
          ),
        ),
      ],
    );
  }
}
