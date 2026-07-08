import 'package:finance/cubit/SettingsCubit.dart';
import 'package:finance/cubit/TransactionCubit.dart';
import 'package:finance/helper/getCurrencySymbol.dart';
import 'package:finance/models/transaction_model.dart';
import 'package:finance/views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static String id = "profile";

  @override
  Widget build(BuildContext context) {
    final currency = context.watch<SettingsCubit>().state.settings.currency;

    final symbol = getCurrencySymbol(currency);
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: BlocBuilder<TransactionsCubit, List<TransactionModel>>(
        builder: (context, transactions) {
          double income = 0;
          double expense = 0;

          for (final transaction in transactions) {
            if (transaction.category == "Salary" ||
                transaction.category == "Investment") {
              income += transaction.amount;
            } else {
              expense += transaction.amount;
            }
          }

          final balance = income - expense;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : null,
                  child: user?.photoURL == null
                      ? const Icon(Icons.person, size: 60)
                      : null,
                ),

                const SizedBox(height: 15),

                Text(
                  user?.email?.split('@').first ?? "User",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  user?.email ?? "No Email",
                  style: TextStyle(color: Colors.grey.shade600),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: _buildCard(
                        "Balance",
                        "$symbol${balance.toStringAsFixed(2)}",
                        Colors.blue,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: _buildCard(
                        "Income",
                        "$symbol${income.toStringAsFixed(2)}",
                        Colors.green,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: _buildCard(
                        "Expense",
                        "$symbol${expense.toStringAsFixed(2)}",
                        Colors.red,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text("Username"),
                        subtitle: Text(user?.email?.split('@').first ?? "User"),
                      ),

                      const Divider(height: 1),

                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text("Email"),
                        subtitle: Text(user?.email ?? ""),
                      ),

                      const Divider(height: 1),

                      const ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text("Account Type"),
                        subtitle: Text("Firebase Authentication"),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // zaid@gmail.com
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text("Change Password"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),

                ListTile(
                  leading: const Icon(Icons.bar_chart),
                  title: const Text("My Statistics"),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginView.id,
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(String title, String value, Color color) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(title),
          ],
        ),
      ),
    );
  }
}
