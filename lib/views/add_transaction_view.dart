import 'package:finance/cubit/SettingsCubit.dart';
import 'package:finance/cubit/TransactionCubit.dart';
import 'package:finance/cubit/notification_cubit.dart';
import 'package:finance/helper/getCurrencySymbol.dart';
import 'package:finance/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionView extends StatefulWidget {
  AddTransactionView({super.key});
  static String id = 'add_transaction';

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String transactionType = "Expense";
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();

    dateController.text =
        "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
  }

  String selectedCategory = "Food";

  @override
  Widget build(BuildContext context) {
    final currency = context.watch<SettingsCubit>().state.settings.currency;

    final symbol = getCurrencySymbol(currency);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Add Transaction",
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Income"),
                        value: "Income",
                        groupValue: transactionType,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() {
                            transactionType = value!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: const Text("Expense"),
                        value: "Expense",
                        groupValue: transactionType,
                        activeColor: Colors.red,
                        onChanged: (value) {
                          setState(() {
                            transactionType = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Transaction Title",
                  prefixIcon: const Icon(Icons.edit_note),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Amount",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      symbol,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.category),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: "Food", child: Text("🍔 Food")),
                  DropdownMenuItem(
                    value: "Transport",
                    child: Text("🚗 Transport"),
                  ),
                  DropdownMenuItem(
                    value: "Shopping",
                    child: Text("🛍 Shopping"),
                  ),
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
                    selectedCategory = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextField(
                controller: dateController,
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2035),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                      dateController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    });
                  }
                },
                decoration: InputDecoration(
                  hintText: "Select Date",
                  prefixIcon: const Icon(Icons.calendar_today),
                  filled: true,
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey.shade800
                      : Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xff3882F6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {
                    if (titleController.text.isEmpty ||
                        amountController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill all fields")),
                      );
                      return;
                    }

                    context.read<TransactionsCubit>().addTransaction(
                      TransactionModel(
                        type: transactionType,
                        title: titleController.text,
                        amount: double.parse(amountController.text),
                        category: selectedCategory,
                        date: selectedDate ?? DateTime.now(),
                      ),
                    );
                    context.read<NotificationCubit>().add(
                      title: "Transaction Added",
                      body:
                          "${titleController.text} - ${amountController.text} $symbol",
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Save Transaction",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
