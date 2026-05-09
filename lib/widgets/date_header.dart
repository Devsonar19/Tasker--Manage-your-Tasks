import 'package:flutter/material.dart';

class DateHeader extends StatelessWidget {
  const DateHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const staticDate = '9th May 2026';
    const staticPending = 1;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          staticDate,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "$staticPending pending tasks",
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
