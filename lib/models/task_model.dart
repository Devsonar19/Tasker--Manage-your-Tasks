import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  final String title;
  final String description;
  final DateTime date;
  final bool isCompleted;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isCompleted
  });

  Map<String, dynamic> toFirestoreMap() {
    return {
      'title': title,
      'description': description,
      'date': Timestamp.fromDate(date),
      'isCompleted': isCompleted,
    };
  }

  factory TaskModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      isCompleted: data['isCompleted'] ?? false,
    );
  }
}