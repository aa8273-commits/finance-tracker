import 'package:finance/cubit/TransactionCubit.dart';
import 'package:finance/models/transaction_model.dart';
import 'package:finance/views/EditTransaction.dart';
import 'package:finance/widgets/itemDetails_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionDetails extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetails({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Details"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.account_balance_wallet,
                      size: 70,
                      color: Colors.blue,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      transaction.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    itemDetails(
                      "Amount",
                      transaction.amount.toStringAsFixed(2),
                    ),

                    itemDetails("Category", transaction.category),

                    itemDetails("Type", transaction.type),

                    itemDetails(
                      "Date",
                      "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.edit),
                label: const Text("Edit"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditTransaction(transaction: transaction),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 5),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                onPressed: () {
                  context.read<TransactionsCubit>().deleteTransaction(
                    transaction,
                  );

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
