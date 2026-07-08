import 'package:finance/cubit/NavCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget itembar(
  BuildContext context, {
  required IconData icon,
  required String title,
  required int index,
  required int currentIndex,
}) {
  final bool selected = currentIndex == index;

  return InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: () {
      context.read<NavCubit>().changeIndex(index);
    },
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xff3882F6).withOpacity(.15)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: selected ? const Color(0xff3882F6) : Colors.grey,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              color: selected ? const Color(0xff3882F6) : Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
