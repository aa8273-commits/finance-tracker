import 'package:finance/models/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsCubit extends Cubit<StatsState> {
  StatsCubit() : super(StatsState(income: 0, expense: 0, categoryTotals: {}));

  void calculate(List<TransactionModel> transactions) {
    double income = 0;
    double expense = 0;

    Map<String, double> categories = {};

    for (final t in transactions) {
      if (t.type == "Income") {
        income += t.amount;
      } else {
        expense += t.amount;

        categories[t.category] = (categories[t.category] ?? 0) + t.amount;
      }
    }

    emit(
      StatsState(income: income, expense: expense, categoryTotals: categories),
    );
  }
}

class StatsState {
  final double income;
  final double expense;
  final Map<String, double> categoryTotals;

  StatsState({
    required this.income,
    required this.expense,
    required this.categoryTotals,
  });

  double get balance => income - expense;
}
