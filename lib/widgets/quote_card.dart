import 'package:flutter/material.dart';
import 'package:tasker/models/quotes_model.dart';
import 'package:tasker/services/api_services.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuotesModel>(
      future: ApiServices().fetchQuotes(),
      builder: (context, asyncSnapshot) {

        if(asyncSnapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }

        final quote = asyncSnapshot.data ?? QuotesModel(
          quote: "Believe you can and you're halfway there.",
          author: "Theodore Rooooooosevelt",
        );


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
        
              Text(
                "\"${quote.quote}\"",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 16),
        
              Text(
                "- ${quote.author}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
