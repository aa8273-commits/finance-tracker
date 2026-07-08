import 'package:finance/cubit/TransactionCubit.dart';
import 'package:finance/models/transaction_model.dart';

import 'package:finance/widgets/CategoryCard.dart';
import 'package:finance/widgets/CategoryDetailsView.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  static String id = 'categories';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, List<TransactionModel>>(
      builder: (context, transactions) {
        final categoryData = {
          "Food": {"icon": Icons.fastfood, "color": Colors.red},

          "Transport": {"icon": Icons.directions_car, "color": Colors.blue},

          "Shopping": {"icon": Icons.shopping_bag, "color": Colors.purple},

          "Gym": {"icon": Icons.fitness_center, "color": Colors.green},

          "Bills": {"icon": Icons.receipt_long, "color": Colors.orange},

          "Health": {"icon": Icons.local_hospital, "color": Colors.teal},

          "Education": {"icon": Icons.school, "color": Colors.indigo},

          "Entertainment": {"icon": Icons.movie, "color": Colors.pink},

          "Travel": {"icon": Icons.flight_takeoff, "color": Colors.cyan},

          "Salary": {"icon": Icons.attach_money, "color": Colors.green},

          "Investment": {"icon": Icons.trending_up, "color": Colors.amber},

          "Other": {"icon": Icons.category, "color": Colors.grey},
        };

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: categoryData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            final categoryName = categoryData.keys.elementAt(index);
            final categoryInfo = categoryData[categoryName]!;

            final total = transactions
                .where((e) => e.category == categoryName)
                .fold(0.0, (sum, item) => sum + item.amount);

            final count = transactions
                .where((e) => e.category == categoryName)
                .length;

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CategoryDetailsView(categoryName: categoryName),
                  ),
                );
              },
              child: CategoryCard(
                title: categoryName,
                icon: categoryInfo["icon"] as IconData,
                color: categoryInfo["color"] as Color,
                amount: total,
                transactions: count,
              ),
            );
          },
        );
      },
    );
  }
}
