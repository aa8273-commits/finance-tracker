import 'package:flutter/material.dart';

IconData getCategoryIcon(String category) {
  switch (category) {
    case "Food":
      return Icons.fastfood;
    case "Transport":
      return Icons.directions_car;
    case "Shopping":
      return Icons.shopping_bag;
    case "Gym":
      return Icons.fitness_center;
    case "Bills":
      return Icons.receipt_long;
    case "Health":
      return Icons.local_hospital;
    case "Education":
      return Icons.school;
    case "Entertainment":
      return Icons.movie;
    case "Travel":
      return Icons.flight_takeoff;
    case "Salary":
      return Icons.attach_money;
    case "Investment":
      return Icons.trending_up;
    default:
      return Icons.category;
  }
}

// Color getCategoryColor(String category) {
//   switch (category) {
//     case "Food":
//       return Colors.red;

//     case "Transport":
//       return Colors.blue;

//     case "Gym":
//       return Colors.green;

//     case "Shopping":
//       return Colors.purple;

//     default:
//       return Colors.grey;
//   }
// }
