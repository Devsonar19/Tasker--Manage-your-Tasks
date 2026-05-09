import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tasker/models/quotes_model.dart';

class ApiServices {
  static const String url = 'https://api.quotable.io/random';

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
      return QuotesModel(
        quote: "Believe you can and you're halfway there.",
        author: "Theodore Roosevelt",
      );
    }
  }
}