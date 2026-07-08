import 'package:flutter/material.dart';

class BackupRestoreView extends StatelessWidget {
  const BackupRestoreView({super.key});

  static String id = "backup_restore";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Backup & Restore"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.backup, size: 90, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              "Keep your financial data safe by creating a backup. "
              "You can restore it anytime if you change your device.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Backup created successfully"),
                    ),
                  );
                },
                icon: const Icon(Icons.cloud_upload),
                label: const Text("Create Backup"),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Backup restored successfully"),
                    ),
                  );
                },
                icon: const Icon(Icons.restore),
                label: const Text("Restore Backup"),
              ),
            ),

            const Spacer(),

            const Text(
              "Last Backup: Not Available",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
