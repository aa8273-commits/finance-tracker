class SettingsModel {
  bool darkMode;
  bool notifications;
  String currency;

  SettingsModel({
    required this.darkMode,
    required this.notifications,
    required this.currency,
  });

  SettingsModel copyWith({
    bool? darkMode,
    bool? notifications,
    String? currency,
  }) {
    return SettingsModel(
      darkMode: darkMode ?? this.darkMode,
      notifications: notifications ?? this.notifications,
      currency: currency ?? this.currency,
    );
  }
}
