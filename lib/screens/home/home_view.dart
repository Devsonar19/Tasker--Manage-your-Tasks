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
                    final pending = asyncSnapshot.data?.length ?? 0;
                    final today = DateFormat('EEEE, MMM d').format(DateTime.now());
      
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(today, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                        const SizedBox(height: 4),
      
                        Text("$pending pending tasks", style: const TextStyle(fontSize: 16, color: Colors.black54)),
                        const SizedBox(height: 24),
      
      
                        const Text("Today’s Tasks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                        const SizedBox(height: 16),



                        if (asyncSnapshot.connectionState == ConnectionState.waiting)
                          const Center(child: CircularProgressIndicator(color: Color(0xFF6FE5B1)))
                        else if (asyncSnapshot.data == null || asyncSnapshot.data!.isEmpty)
                          const Center(child: Text("No tasks for today. You're all caught up!"))
                        else if(asyncSnapshot.hasError)
                          Center(child: Text(asyncSnapshot.error.toString()))
                        else
                          ...asyncSnapshot.data!.map((task) => TaskCard(task: task)),
      
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
