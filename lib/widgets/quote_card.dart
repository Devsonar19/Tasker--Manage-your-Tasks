import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFE0F7FA).withOpacity(0.3),
          ],
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.format_quote_rounded,
              color: Colors.grey.withOpacity(0.3),
              size: 40,
            ),
          ),

          const Text(
            "\"Believe you can and you're halfway there.\"",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            "- Theodore Roosevelt",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
