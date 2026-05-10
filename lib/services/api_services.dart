import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:tasker/models/quotes_model.dart';

class ApiServices {
  String get url => 'https://dummyjson.com/quotes/random';

  //if internet is not available or API doesnt work, will use backup quotes
  final List<QuotesModel> backupQuotes = [
    QuotesModel(quote: "Believe you can and you're halfway there.", author: "Theodore Roosevelt"),
    QuotesModel(quote: "It does not matter how slowly you go as long as you do not stop.", author: "Confucius"),
    QuotesModel(quote: "Everything you can imagine is real.", author: "Pablo Picasso"),
    QuotesModel(quote: "Do what you can, with what you have, where you are.", author: "Theodore Roosevelt"),
    QuotesModel(quote: "Act as if what you do makes a difference. It does.", author: "William James"),
  ];

  Future<QuotesModel> fetchRandomQuote() async {
    try {
      final String url = 'https://api.quotable.io/random?timestamp=${DateTime.now().millisecondsSinceEpoch}';

      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 4),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return QuotesModel.fromJson(data);
      } else {
        throw Exception("Failed to load quote");
      }
    } catch (e) {
      print("🚨 API FETCH FAILED: $e");
      final randomIndex = Random().nextInt(backupQuotes.length);
      return Future.value(backupQuotes[randomIndex]);
    }
  }

  Future<QuotesModel> fetchQuotes() async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 5),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return QuotesModel.fromJson(data);
      } else {
        throw Exception("Failed to load quote");
      }
    } catch (e) {
      final randomIndex = Random().nextInt(backupQuotes.length);
      return backupQuotes[randomIndex];
    }
  }
}