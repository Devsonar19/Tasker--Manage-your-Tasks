import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String description;
  final String time;
  final bool isCompleted;

  const TaskCard({super.key, required this.title, required this.description, required this.time, required this.isCompleted});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool isCompleted;

  @override
  void initState() {
    isCompleted = widget.isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              value: isCompleted,
              activeColor: const Color(0xFF6FE5B1),
              checkColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: const BorderSide(color: Colors.grey, width: 1.5),
              onChanged: (bool? value) {
                setState(() {
                  isCompleted = value ?? false;
                });
                //will do it later
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
                      flex: 3,
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.grey),
                        onPressed: () {
                          //edit/delete
                        },
                        constraints: const BoxConstraints(),
                      ),
                    ),
                  ],
                ),

                Text(
                  widget.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Icon(Icons.access_time_filled, size: 16, color: Colors.red[300]),
                    const SizedBox(width: 4),
                    Text(
                      widget.time,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.red[300],
                          fontWeight: FontWeight.bold
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
