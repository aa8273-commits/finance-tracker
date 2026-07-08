import 'package:finance/cubit/SettingsCubit.dart';
import 'package:finance/cubit/TransactionCubit.dart';
import 'package:finance/helper/getCurrencySymbol.dart';
import 'package:finance/models/transaction_model.dart';
import 'package:finance/widgets/Notifications_widget.dart';
import 'package:finance/widgets/_infoCard.dart';
import 'package:finance/widgets/transactionTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewWidgets extends StatelessWidget {
  const HomeViewWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = context.watch<SettingsCubit>().state.settings.currency;
    final symbol = getCurrencySymbol(currency);

    return BlocBuilder<TransactionsCubit, List<TransactionModel>>(
      builder: (context, transactions) {
        double income = 0;
        double expense = 0;

        for (final transaction in transactions) {
          if (transaction.type == "Income") {
            income += transaction.amount;
          } else {
            expense += transaction.amount;
          }
        }

        final balance = income - expense;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff1E293B), Color(0xff0F172A)],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome Back 👋",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              FirebaseAuth.instance.currentUser?.displayName ??
                                  "User",

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              NotificationsWidget.id,
                            );
                          },
                          icon: const CircleAvatar(
                            backgroundColor: Colors.white24,
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Balance",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "$symbol${balance.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: infoCard(
                      title: "Income",
                      amount: "$symbol${income.toStringAsFixed(2)}",
                      color: Colors.green,
                      icon: Icons.arrow_downward,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: infoCard(
                      title: "Expenses",
                      amount: "$symbol${expense.toStringAsFixed(2)}",
                      color: Colors.red,
                      icon: Icons.arrow_upward,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Recent Transactions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 15),

              ...transactions.map(
                (transaction) => transactionTile(
                  icon: Icons.account_balance_wallet,
                  iconColor: transaction.type == "Income"
                      ? Colors.green
                      : Colors.red,
                  title: transaction.title,
                  date: transaction.date.toString().substring(0, 10),
                  amount:
                      "${transaction.type == "Income" ? "+" : "-"}$symbol${transaction.amount}",
                  amountColor: transaction.type == "Income"
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
