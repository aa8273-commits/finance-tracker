import 'package:finance/models/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsCubit extends Cubit<List<TransactionModel>> {
  TransactionsCubit() : super([]);

  void addTransaction(TransactionModel transaction) {
    emit([...state, transaction]);
  }

  List<TransactionModel> getByCategory(String category) {
    return state.where((e) => e.category == category).toList();
  }

  double getCategoryTotal(String category) {
    return state
        .where((e) => e.category == category)
        .fold(0, (sum, item) => sum + item.amount);
  }

  void deleteTransaction(TransactionModel transaction) {
    final list = List<TransactionModel>.from(state);
    list.remove(transaction);
    emit(list);
  }

  void updateTransaction(
    TransactionModel oldTransaction,
    TransactionModel newTransaction,
  ) {
    final list = List<TransactionModel>.from(state);

    final index = list.indexOf(oldTransaction);

    if (index != -1) {
      list[index] = newTransaction;
      emit(list);
    }
  }
}
