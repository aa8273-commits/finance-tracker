import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/models/notification_model.dart';

class NotificationCubit extends Cubit<List<NotificationModel>> {
  NotificationCubit() : super([]);

  void add({required String title, required String body}) {
    emit([
      NotificationModel(title: title, body: body, date: DateTime.now()),
      ...state,
    ]);
  }

  void remove(NotificationModel item) {
    final list = List<NotificationModel>.from(state);
    list.remove(item);
    emit(list);
  }

  void clear() {
    emit([]);
  }
}
