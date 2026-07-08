import 'package:finance/models/transaction_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyBarChart extends StatelessWidget {
  final List<TransactionModel> transactions;

  const MonthlyBarChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    List<double> months = List.filled(12, 0);

    for (final t in transactions) {
      if (t.type == "Expense") {
        months[t.date.month - 1] += t.amount;
      }
    }

    double maxY = 100;

    if (months.isNotEmpty) {
      maxY = months.reduce((a, b) => a > b ? a : b);
      if (maxY < 100) {
        maxY = 100;
      } else {
        maxY += maxY * .2;
      }
    }

    return SizedBox(
      height: 230,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          alignment: BarChartAlignment.spaceAround,

          borderData: FlBorderData(show: false),

          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxY / 5,
          ),

          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 35),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  const monthsName = [
                    "Jan",
                    "Feb",
                    "Mar",
                    "Apr",
                    "May",
                    "Jun",
                    "Jul",
                    "Aug",
                    "Sep",
                    "Oct",
                    "Nov",
                    "Dec",
                  ];

                  if (value.toInt() < 0 || value.toInt() > 11) {
                    return const SizedBox();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      monthsName[value.toInt()],
                      style: const TextStyle(fontSize: 11),
                    ),
                  );
                },
              ),
            ),
          ),

          barGroups: List.generate(
            12,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: months[index],
                  width: 18,
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
