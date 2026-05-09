import 'package:flutter/material.dart';
import 'package:tasker/screens/main_layout.dart';

void main() {
  runApp(const TaskerApp());
}

class TaskerApp extends StatelessWidget {
  const TaskerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasker',
      theme: ThemeData(
        fontFamily: 'Inter'
      ),
      home: const TaskerHomePage(),
    );
  }
}

class TaskerHomePage extends StatefulWidget {
  const TaskerHomePage({super.key});

  @override
  State<TaskerHomePage> createState() => _TaskerHomePageState();
}

class _TaskerHomePageState extends State<TaskerHomePage> {

  @override
  Widget build(BuildContext context) {
    return MainLayout();
  }
}
