import 'package:finance/cubit/SettingsCubit.dart';
import 'package:finance/widgets/Setting_Widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  final currencies = ["USD", "EGP", "EUR", "GBP", "SAR", "AED", "KWD"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),

      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();

          return SettingWidget(
            currencies: currencies,
            cubit: cubit,
            state: state,
          );
        },
      ),
    );
  }
}
