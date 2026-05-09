import 'package:flutter/material.dart';
import '../widgets/task_bottom.dart';
import 'completed/completed_view.dart';
import 'home/home_view.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int idx = 0;

  final List<Widget> views = [
    const HomeView(),
    const CompletedView()
  ];

  void showAddTaskSheet() {
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
        child: const TaskBottom(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: IndexedStack(
            index: idx,
            children: views,
          )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskSheet,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, size: 28),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        onDestinationSelected: (index) {
          setState(() {
            idx = index;
          });
        },
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFF6FE5B1),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            selectedIcon: Icon(Icons.check_circle),
            label: 'Completed',
          ),
        ],
      ),
    );
  }
}
