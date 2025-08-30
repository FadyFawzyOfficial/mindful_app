import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/db_helper.dart';
import 'data/quote.dart';
import 'data/quotes_list_screen.dart';
import 'settings_screen.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  var quote = Quote(text: '', author: '');
  static const _quoteUrl = 'https://zenquotes.io/api/random';
  late Future<Quote> _futureQuote;

  @override
  void initState() {
    super.initState();
    _futureQuote = fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mindful Quote'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_rounded),
            onPressed: _goToSettings,
          ),
          IconButton(
            icon: const Icon(Icons.list_rounded),
            onPressed: _goToQuotesList,
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => setState(() {
              _futureQuote = fetchQuote();
            }),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _futureQuote,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            quote = snapshot.data!;
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_rounded),
        onPressed: () {
          final dbHelper = DbHelper();
          dbHelper
              .insertQuote(quote)
              .then(
                (id) => ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(
                        id != 0
                            ? 'The quote was saved successfully'
                            : 'An error occurred. The quote could not be saved',
                      ),
                    ),
                  ),
              );
        },
      ),
    );
  }

  void _goToSettings() => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SettingsScreen()),
  );

  void _goToQuotesList() => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => QuoteListScreen()),
  );

  Future<Quote> fetchQuote() async {
    final Uri url = Uri.parse(_quoteUrl);
    final response = await http.get(url);
    return response.statusCode == 200
        ? Quote.fromJson(response.body)
        : Quote(text: 'Failed to load quote', author: '');
  }
}
