import 'package:finance/models/settingmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
    : super(
        SettingsState(
          SettingsModel(darkMode: false, notifications: true, currency: "USD"),
        ),
      );

  void changeDarkMode(bool value) {
    emit(SettingsState(state.settings.copyWith(darkMode: value)));
  }

  void changeNotification(bool value) {
    emit(SettingsState(state.settings.copyWith(notifications: value)));
  }

  void changeCurrency(String currency) {
    emit(SettingsState(state.settings.copyWith(currency: currency)));
  }
}

class SettingsState {
  final SettingsModel settings;

  SettingsState(this.settings);
}
