import 'package:finance/models/transaction_model.dart';
import 'package:finance/widgets/MonthlyBarChart.dart';
import 'package:flutter/material.dart';

Widget monthly(List<TransactionModel> transactions) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: MonthlyBarChart(transactions: transactions),
  );
}
