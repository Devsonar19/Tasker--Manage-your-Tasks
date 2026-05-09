import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task_model.dart';

class FirestoreServices {
  final FirebaseFirestore firestoreDb = FirebaseFirestore.instance;
  final String? uid =  FirebaseAuth.instance.currentUser?.uid;

  CollectionReference get taskCollection{
    if(uid == null){
      throw Exception('User not authenticated');
    }
    return firestoreDb.collection('users').doc(uid).collection('tasks');
  }

  Future<void> addTask(TaskModel task) async {
    await taskCollection.add(task.toFirestoreMap());
  }

  Stream<List<TaskModel>> getTasks({bool isCompleted = false}) {
  return taskCollection
      .where('isCompleted', isEqualTo: isCompleted)
      .orderBy('date', descending: false)
      .snapshots()
      .map((snapshot) => snapshot.docs
      .map((doc) => TaskModel.fromDocument(doc))
      .toList());
  }

  Future<void> updateTask(TaskModel task) async {
    if (task.id == null) return;
    await taskCollection.doc(task.id).update(task.toFirestoreMap());
  }

  Future<void> toggleTaskStatus(String id, bool currentStatus) async {
    await taskCollection.doc(id).update({'isCompleted': !currentStatus});
  }

  Future<void> deleteTask(String id) async {
    await taskCollection.doc(id).delete();
  }
}