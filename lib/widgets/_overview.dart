import 'package:finance/models/transaction_model.dart';
import 'package:finance/widgets/ExpensePieChart.dart';
import 'package:finance/widgets/MonthlyBarChart.dart';
import 'package:flutter/material.dart';

Widget overview(List<TransactionModel> transactions) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ExpensePieChart(transactions: transactions),

          const SizedBox(height: 20),

          MonthlyBarChart(transactions: transactions),

          const SizedBox(height: 20),

          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Transaction Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),

          const SizedBox(height: 10),

          ...transactions.map(
            (t) => Card(
              child: ListTile(
                title: Text(t.title),
                subtitle: Text(t.category),
                trailing: Text("${t.amount}"),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
