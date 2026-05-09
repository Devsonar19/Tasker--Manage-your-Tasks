class QuotesModel {
  final String quote;
  final String author;

  QuotesModel({
    required this.quote,
    required this.author,
  });

  factory QuotesModel.fromJson(Map<String, dynamic> json) {
    return QuotesModel(
      quote: json['quote'] ?? "Not Found",
      author: json['author'] ?? "Not Known",
    );
  }
}