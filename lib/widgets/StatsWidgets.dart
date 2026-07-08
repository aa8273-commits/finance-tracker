import 'package:finance/models/transaction_model.dart';
import 'package:finance/views/TransactionDetails.dart';
import 'package:finance/widgets/_overview.dart';
import 'package:flutter/material.dart';

class StatsWidgets extends StatelessWidget {
  const StatsWidgets({
    super.key,
    required this.transactions,
    required this.income,
    required this.expense,
  });
  final List<TransactionModel> transactions;
  final double income;
  final double expense;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),

      children: [
        overview(transactions),

        const SizedBox(height: 25),

        Row(
          children: [
            Expanded(
              child: Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.arrow_downward,
                    color: Colors.green,
                  ),
                  title: const Text("Income"),
                  subtitle: Text(
                    income.toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.arrow_upward, color: Colors.red),
                  title: const Text("Expense"),
                  subtitle: Text(
                    expense.toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        Card(
          child: ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text("Transactions"),
            trailing: Text(
              transactions.length.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          "Recent Transactions",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),

        const SizedBox(height: 10),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final t = transactions.reversed.toList()[index];

            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TransactionDetails(transaction: t),
                    ),
                  );
                },

                leading: CircleAvatar(
                  backgroundColor: t.type == "Income"
                      ? Colors.green.shade100
                      : Colors.red.shade100,

                  child: Icon(
                    t.type == "Income"
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                  ),
                ),

                title: Text(t.title),

                subtitle: Text(
                  "${t.category}\n${t.date.day}/${t.date.month}/${t.date.year}",
                ),

                trailing: Text(
                  "${t.type == "Income" ? "+" : "-"}${t.amount}",
                  style: TextStyle(
                    color: t.type == "Income" ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
