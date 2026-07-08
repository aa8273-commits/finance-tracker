import 'package:finance/widgets/itembar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavbar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 8,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SafeArea(
        child: SizedBox(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              itembar(
                context,
                icon: Icons.home_rounded,
                title: "Home",
                index: 0,
                currentIndex: currentIndex,
              ),

              itembar(
                context,
                icon: Icons.bar_chart_rounded,
                title: "Stats",
                index: 1,
                currentIndex: currentIndex,
              ),

              const SizedBox(width: 40),

              itembar(
                context,
                icon: Icons.grid_view_rounded,
                title: "Categories",
                index: 2,
                currentIndex: currentIndex,
              ),

              itembar(
                context,
                icon: Icons.settings_rounded,
                title: "Settings",
                index: 3,
                currentIndex: currentIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
