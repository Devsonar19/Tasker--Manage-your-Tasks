import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasker/services/firestore_services.dart';

import '../../models/task_model.dart';
import '../../services/auth/auth_services.dart';
import '../../widgets/date_header.dart';
import '../../widgets/quote_card.dart';
import '../../widgets/task_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            tooltip: 'Logout',
            onPressed: () async {
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to log out?"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: const Text("Cancel", style: TextStyle(color: Colors.black54)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pop(dialogContext);
                          await AuthServices().logout();
                        },
                        child: const Text("Logout"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const QuoteCard(),
              const SizedBox(height: 24),

              StreamBuilder<List<TaskModel>>(
                  stream: FirestoreServices().getTasks(isCompleted: false),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(color: Color(0xFF6FE5B1)),
                      ));
                    }

                    if (asyncSnapshot.hasError) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          "Could not load tasks. Check connection.",
                          style: TextStyle(color: Colors.red[800]),
                        ),
                      );
                    }

                    final now = DateTime.now();
                    final allPending = asyncSnapshot.data ?? [];

                    final todayTasks = allPending.where((task) {
                      return task.date.year == now.year &&
                          task.date.month == now.month &&
                          task.date.day == now.day;
                    }).toList();

                    final pendingCount = todayTasks.length;
                    final todayStr = DateFormat('EEEE, MMM d').format(now);

                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(todayStr, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                          const SizedBox(height: 4),

                          Text("$pendingCount pending tasks for today", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                          const SizedBox(height: 24),

                          const Text("Today’s Tasks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                          const SizedBox(height: 16),

                          if (todayTasks.isEmpty)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: const Text(
                                "No tasks for today. You're all caught up!",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black54),
                              ),
                            )
                          else
                            ...todayTasks.map((task) => TaskCard(task: task)),

                          const SizedBox(height: 80),
                        ]
                    );
                  }
              ),
      
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
