import 'package:finance/cubit/Auth_gate.dart';
import 'package:finance/cubit/NavCubit.dart';
import 'package:finance/cubit/SettingsCubit.dart';
import 'package:finance/cubit/TransactionCubit.dart';
import 'package:finance/cubit/notification_cubit.dart';
import 'package:finance/firebase_options.dart';
import 'package:finance/views/Stats_view%20.dart';
import 'package:finance/views/add_transaction_view.dart';
import 'package:finance/views/categories_view.dart';
import 'package:finance/views/home_view.dart';
import 'package:finance/views/login_view.dart';
import 'package:finance/views/register_view.dart';
import 'package:finance/views/splash_view.dart';
import 'package:finance/views/AboutAppView.dart';
import 'package:finance/views/BackupRestoreView.dart';
import 'package:finance/widgets/Notifications_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavCubit()),
        BlocProvider(create: (_) => TransactionsCubit()),
        BlocProvider(create: (_) => SettingsCubit()),
        BlocProvider(create: (_) => NotificationCubit()),
      ],
      child: const Finance(),
    ),
  );
}

class Finance extends StatelessWidget {
  const Finance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xffF5F7FA),
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xff121212),
          ),

          themeMode: state.settings.darkMode ? ThemeMode.dark : ThemeMode.light,
          routes: {
            HomeView.id: (context) => const HomeView(),
            LoginView.id: (context) => const LoginView(),
            RegisterView.id: (context) => const RegisterView(),
            SplashHomeView.id: (context) => const SplashHomeView(),
            AddTransactionView.id: (context) => AddTransactionView(),
            CategoriesView.id: (context) => const CategoriesView(),
            StatsView.id: (context) => const StatsView(),
            AboutAppView.id: (context) => const AboutAppView(),
            BackupRestoreView.id: (context) => const BackupRestoreView(),
            NotificationsWidget.id: (context) => const NotificationsWidget(),
          },

          home: const AuthGate(),
        );
      },
    );
  }
}
