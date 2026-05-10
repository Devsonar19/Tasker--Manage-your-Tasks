import 'package:flutter/material.dart';

import '../../models/task_model.dart';
import '../../services/firestore_services.dart';
import '../../widgets/task_card.dart';

class CompletedView extends StatelessWidget {
  const CompletedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Tasks', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<List<TaskModel>>(
        stream: FirestoreServices().getTasks(isCompleted: true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF6FE5B1)));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No completed tasks yet.\nGet to work!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return TaskCard(task: snapshot.data![index]);
            },
          );
        },
      ),
    );
  }
}
