import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasker/widgets/task_bottom.dart';
import '../models/task_model.dart';
import '../services/firestore_services.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('MMM d, h:mm a').format(task.date);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              value: task.isCompleted,
              activeColor: const Color(0xFF6FE5B1),
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              side: const BorderSide(color: Colors.grey, width: 1.5),
              onChanged: (bool? value) {
                if (task.id != null) {
                  FirestoreServices().toggleTaskStatus(task.id!, task.isCompleted);
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: task.isCompleted ? Colors.grey : Colors.black,
                          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                    ),

                    //deleting
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_horiz, color: Colors.grey),
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit Task')),
                        const PopupMenuItem(value: 'delete', child: Text('Delete Task')),
                      ],
                      onSelected: (value) {
                        if (value == 'delete' && task.id != null) {
                          FirestoreServices().deleteTask(task.id!);
                        }

                        else if (value == 'edit') {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                            ),
                            builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: TaskBottom(task: task),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                Text(
                  task.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.4),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.access_time_filled, size: 16, color: task.isCompleted ? Colors.grey : Colors.red[300]),
                    const SizedBox(width: 4),
                    Text(
                      formattedTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: task.isCompleted ? Colors.grey : Colors.red[300],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}