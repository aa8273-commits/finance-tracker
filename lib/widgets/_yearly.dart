import 'package:finance/models/transaction_model.dart';
import 'package:finance/widgets/YearlyBarChart.dart';

import 'package:flutter/material.dart';

Widget yearly(List<TransactionModel> transactions) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: YearlyBarChart(transactions: transactions),
  );
}
