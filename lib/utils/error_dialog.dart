import 'package:flutter/material.dart';

class ErrorDialog {
  static void show(BuildContext context, dynamic error) {
    String errorMessage = error.toString();

    String cleanMessage = errorMessage.replaceAll('Exception: ', '');

    if (errorMessage.contains('SocketException') ||
        errorMessage.contains('network-request-failed') ||
        errorMessage.contains('unavailable')) {
      cleanMessage = "Please check your internet connection and try again.";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.wifi_off_rounded, color: Colors.redAccent),
            SizedBox(width: 8),
            Text("Oops!"),
          ],
        ),
        content: Text(cleanMessage, style: const TextStyle(fontSize: 15)),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}