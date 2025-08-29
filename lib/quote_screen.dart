import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/quote.dart';
import 'settings_screen.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  static const _quoteUrl = 'https://zenquotes.io/api/random';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mindful Quote'),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            ),
            icon: const Icon(Icons.settings_rounded),
          ),
          IconButton(
            onPressed: () => fetchQuote(),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchQuote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final quote = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    quote.text,
                    style: const TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    quote.author,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Quote> fetchQuote() async {
    final Uri url = Uri.parse(_quoteUrl);
    final response = await http.get(url);
    return response.statusCode == 200
        ? Quote.fromJson(response.body)
        : Quote(text: 'Failed to load quote', author: '');
  }
}
