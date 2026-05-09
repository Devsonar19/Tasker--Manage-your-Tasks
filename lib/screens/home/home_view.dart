import 'package:flutter/material.dart';

import '../../widgets/date_header.dart';
import '../../widgets/quote_card.dart';
import '../../widgets/task_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const QuoteCard(),
            const SizedBox(height: 24),

            const DateHeader(),
            const SizedBox(height: 24),

            const Text(
              "Today’s Tasks",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            const TaskCard(
              title: "Task 1",
              description: "Compile all departmental expense reports and finalize the quarterly budget presentation...",
              time: "Today, 2:00 PM",
              isCompleted: false,
            ),
            const TaskCard(
              title: "task 2",
              description: "Integrate the new modern corporate visual tokens into the Figma library...",
              time: "Today, 4:30 PM",
              isCompleted: false,
            ),
            const TaskCard(
              title: "task 3",
              description: "Daily sync with engineering and product teams...",
              time: "Completed",
              isCompleted: true,
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
