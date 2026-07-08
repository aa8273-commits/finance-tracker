import 'package:finance/views/ProfileView.dart';
import 'package:flutter/material.dart';

class profileWidget extends StatelessWidget {
  const profileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person),
      title: GestureDetector(
        child: const Text("Profile"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileView()),
          );
        },
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
