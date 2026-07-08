import 'package:finance/cubit/SettingsCubit.dart';
import 'package:finance/helper/getCurrencySymbol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoneyText extends StatelessWidget {
  final double amount;
  final TextStyle? style;

  const MoneyText({super.key, required this.amount, this.style});

  @override
  Widget build(BuildContext context) {
    final symbol = getCurrencySymbol(
      context.watch<SettingsCubit>().state.settings.currency,
    );

    return Text("$symbol${amount.toStringAsFixed(2)}", style: style);
  }
}
