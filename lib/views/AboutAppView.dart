import 'package:flutter/material.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({super.key});

  static String id = "aboutApp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About App"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              child: Icon(Icons.account_balance_wallet, size: 50),
            ),
            SizedBox(height: 20),
            Text(
              "Finance Tracker",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Version 1.0.0", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 30),
            Text(
              "Finance Tracker is a personal finance management application "
              "that helps users track their income and expenses, "
              "categorize transactions, and view detailed statistics "
              "through charts and reports.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Text(
              "Developed with Flutter ❤️",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("© 2026 All Rights Reserved"),
          ],
        ),
      ),
    );
  }
}
