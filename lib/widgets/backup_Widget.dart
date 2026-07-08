import 'package:finance/views/BackupRestoreView.dart';
import 'package:flutter/material.dart';

class backupWidget extends StatelessWidget {
  const backupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.backup),
      title: const Text("Backup & Restore"),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: () {
        Navigator.pushNamed(context, BackupRestoreView.id);
      },
    );
  }
}
