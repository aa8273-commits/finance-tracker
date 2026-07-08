import 'package:finance/cubit/TransactionCubit.dart';
import 'package:finance/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTransaction extends StatefulWidget {
  final TransactionModel transaction;

  const EditTransaction({super.key, required this.transaction});

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  late TextEditingController titleController;
  late TextEditingController amountController;

  late String category;
  late String type;

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.transaction.title);

    amountController = TextEditingController(
      text: widget.transaction.amount.toString(),
    );

    category = widget.transaction.category;
    type = widget.transaction.type;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Transaction"), centerTitle: true),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Amount"),
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: category,
              decoration: const InputDecoration(labelText: "Category"),
              items: const [
                DropdownMenuItem(value: "Food", child: Text("🍔 Food")),
                DropdownMenuItem(
                  value: "Transport",
                  child: Text("🚗 Transport"),
                ),
                DropdownMenuItem(value: "Shopping", child: Text("🛍 Shopping")),
                DropdownMenuItem(value: "Gym", child: Text("💪 Gym")),
                DropdownMenuItem(value: "Bills", child: Text("📄 Bills")),
                DropdownMenuItem(value: "Health", child: Text("🏥 Health")),
                DropdownMenuItem(
                  value: "Education",
                  child: Text("🎓 Education"),
                ),
                DropdownMenuItem(
                  value: "Entertainment",
                  child: Text("🎬 Entertainment"),
                ),
                DropdownMenuItem(value: "Travel", child: Text("✈ Travel")),
                DropdownMenuItem(value: "Salary", child: Text("💵 Salary")),
                DropdownMenuItem(
                  value: "Investment",
                  child: Text("📈 Investment"),
                ),
                DropdownMenuItem(value: "Other", child: Text("📦 Other")),
              ],
              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: type,
              items: const [
                DropdownMenuItem(value: "Income", child: Text("Income")),

                DropdownMenuItem(value: "Expense", child: Text("Expense")),
              ],
              onChanged: (v) {
                setState(() {
                  type = v!;
                });
              },
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Update Transaction"),

                onPressed: () {
                  final updated = TransactionModel(
                    title: titleController.text,
                    amount: double.parse(amountController.text),
                    category: category,
                    type: type,
                    date: widget.transaction.date,
                  );

                  context.read<TransactionsCubit>().updateTransaction(
                    widget.transaction,
                    updated,
                  );

                  Navigator.pop(context);
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
