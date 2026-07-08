import 'package:finance/cubit/notification_cubit.dart';
import 'package:finance/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({super.key});

  static String id = "notifications";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<NotificationCubit>().clear();
            },
            icon: const Icon(Icons.delete_sweep),
          ),
        ],
      ),
      body: BlocBuilder<NotificationCubit, List<NotificationModel>>(
        builder: (context, notifications) {
          if (notifications.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none, size: 80, color: Colors.grey),
                  SizedBox(height: 15),
                  Text(
                    "No Notifications Yet",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text("Your recent activity will appear here."),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final item = notifications[index];

              return Card(
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.notifications)),
                  title: Text(item.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.body),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat("dd/MM/yyyy hh:mm a").format(item.date),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<NotificationCubit>().remove(item);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
