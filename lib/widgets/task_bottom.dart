import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/firestore_services.dart';
import '../utils/error_dialog.dart';

class TaskBottom extends StatefulWidget {
  final TaskModel? task;
  const TaskBottom({super.key, this.task});

  @override
  State<TaskBottom> createState() => _TaskBottomState();
}

class _TaskBottomState extends State<TaskBottom> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descController.text = widget.task!.description;
      selectedDate = widget.task!.date;
    }
  }

  void saveTask() async {
    if (formKey.currentState!.validate()) {
      try {
        final taskToSave = TaskModel(
          id: widget.task?.id,
          title: titleController.text,
          description: descController.text,
          date: selectedDate,
          isCompleted: widget.task?.isCompleted ?? false,
        );

        if (widget.task == null) {
          await FirestoreServices().addTask(taskToSave);
        } else {
          await FirestoreServices().updateTask(taskToSave);
        }

        if (!mounted) return;
        Navigator.of(context).pop();

      } catch (e) {
        if (!mounted) return;
        ErrorDialog.show(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                isEditing ? "Edit Task" : "Add New Task",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Task Title', border: OutlineInputBorder()),
              validator: (val) => val!.isEmpty ? 'Please enter a title' : null,
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
              maxLines: 3,
              validator: (val) => val!.isEmpty ? 'Please enter a description' : null,
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: saveTask,
                child: const Text("Save Task", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}