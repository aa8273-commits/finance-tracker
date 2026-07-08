import 'package:finance/cubit/TransactionCubit.dart';
import 'package:finance/helper/getCategoryIcon.dart';

import 'package:finance/models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailsView extends StatelessWidget {
  final String categoryName;

  const CategoryDetailsView({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: BlocBuilder<TransactionsCubit, List<TransactionModel>>(
        builder: (context, state) {
          final transactions = state
              .where((e) => e.category == categoryName)
              .toList();

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final item = transactions[index];

              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.withOpacity(.15),
                    child: Icon(
                      getCategoryIcon(item.category),
                      color: Colors.blue,
                    ),
                  ),
                  title: Text(item.title),
                  subtitle: Text(
                    "${item.date.day}/${item.date.month}/${item.date.year}",
                  ),
                  trailing: Text(
                    "\$${item.amount}",
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
