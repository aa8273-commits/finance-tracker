import 'package:finance/views/TransactionDetails.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:finance/models/transaction_model.dart';

class ExpensePieChart extends StatelessWidget {
  final List<TransactionModel> transactions;

  const ExpensePieChart({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    Map<String, double> categories = {};

    for (var t in transactions) {
      if (t.type == "Expense") {
        categories[t.category] = (categories[t.category] ?? 0) + t.amount;
      }
    }

    double total = categories.values.fold(0, (a, b) => a + b);

    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.pink,
      Colors.amber,
    ];

    int i = 0;

    List<Color> usedColors = [];

    final sections = categories.entries.map((e) {
      final color = colors[i % colors.length];
      usedColors.add(color);

      i++;

      return PieChartSectionData(
        value: e.value,
        color: color,
        radius: 35,
        title: "",
      );
    }).toList();

    return SizedBox(
      height: 220,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 55,
                sectionsSpace: 3,
                sections: sections,
              ),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            flex: 5,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final item = categories.entries.elementAt(index);

                final percent = total == 0 ? 0 : item.value / total * 100;

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TransactionDetails(
                          transaction: transactions.firstWhere(
                            (e) => e.category == item.key,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: usedColors[index],
                            shape: BoxShape.circle,
                          ),
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            item.key,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),

                        Text(
                          "${percent.toStringAsFixed(0)}%",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
