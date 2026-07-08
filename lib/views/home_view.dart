import 'package:finance/cubit/NavCubit.dart';

import 'package:finance/views/Settingsviews.dart';
import 'package:finance/views/Stats_view%20.dart';
import 'package:finance/views/add_transaction_view.dart';
import 'package:finance/views/categories_view.dart';
import 'package:finance/widgets/bottomNavigationBar.dart';
import 'package:finance/widgets/homeView_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static String id = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: BlocBuilder<NavCubit, int>(
        builder: (context, index) {
          return IndexedStack(
            index: index,
            children: [
              HomeViewWidgets(),
              StatsView(),
              CategoriesView(),
              SettingsScreen(),
            ],
          );
        },
      ),

      bottomNavigationBar: BlocBuilder<NavCubit, int>(
        builder: (context, index) {
          return CustomBottomNavbar(currentIndex: index);
        },
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [Color(0xff4A90E2), Color(0xff357ABD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff3882F6).withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          onPressed: () {
            Navigator.pushNamed(context, AddTransactionView.id);
          },
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
