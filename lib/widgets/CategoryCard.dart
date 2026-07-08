import 'package:finance/cubit/SettingsCubit.dart';
import 'package:finance/helper/getCurrencySymbol.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final double amount;
  final int transactions;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.amount,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color.withOpacity(.2),
            child: Icon(icon, color: color, size: 28),
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 4),

          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return Text(
                "${getCurrencySymbol(state.settings.currency)}${amount.toStringAsFixed(0)}",
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            },
          ),

          const SizedBox(height: 8),

          Text(
            "\$${amount.toStringAsFixed(0)}",
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
