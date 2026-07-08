import 'package:flutter/material.dart';

Widget itemDetails(String title, String value) {
  return ListTile(
    title: Text(title),
    trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}
