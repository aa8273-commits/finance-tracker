import 'package:finance/models/transaction_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class YearlyBarChart extends StatelessWidget {
  final List<TransactionModel> transactions;

  const YearlyBarChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    Map<int, double> years = {};

    for (final t in transactions) {
      if (t.type == "Expense") {
        years[t.date.year] = (years[t.date.year] ?? 0) + t.amount;
      }
    }

    return SizedBox(
      height: 250,
      child: BarChart(
        BarChartData(
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: true),

          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final list = years.keys.toList()..sort();

                  if (value.toInt() >= list.length) {
                    return const SizedBox();
                  }

                  return Text(
                    list[value.toInt()].toString(),
                    style: const TextStyle(fontSize: 11),
                  );
                },
              ),
            ),
          ),

          barGroups: List.generate(years.length, (index) {
            final list = years.entries.toList()
              ..sort((a, b) => a.key.compareTo(b.key));

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: list[index].value,
                  width: 18,
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
