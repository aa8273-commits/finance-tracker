import 'package:finance/cubit/TransactionCubit.dart';
import 'package:finance/models/transaction_model.dart';

import 'package:finance/widgets/StatsWidgets.dart';
import 'package:finance/widgets/_monthly.dart';

import 'package:finance/widgets/YearlyBarChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  static String id = "stats";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Statistics"),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Overview"),
              Tab(text: "Monthly"),
              Tab(text: "Yearly"),
            ],
          ),
        ),

        body: BlocBuilder<TransactionsCubit, List<TransactionModel>>(
          builder: (context, transactions) {
            double income = 0;
            double expense = 0;

            for (final t in transactions) {
              if (t.type == "Income") {
                income += t.amount;
              } else {
                expense += t.amount;
              }
            }

            return TabBarView(
              children: [
                _overviewPage(context, transactions, income, expense),

                monthly(transactions),

                YearlyBarChart(transactions: transactions),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _overviewPage(
    BuildContext context,
    List<TransactionModel> transactions,
    double income,
    double expense,
  ) {
    return StatsWidgets(
      transactions: transactions,
      income: income,
      expense: expense,
    );
  }
}
