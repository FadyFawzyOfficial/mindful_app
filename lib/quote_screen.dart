import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  static const _quoteUrl = 'https://zenquotes.io/api/random';

  @override
  void initState() {
    super.initState();
    fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mindful Quote')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quote',
              style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
            ),
            Text(
              'Author',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Future fetchQuote() async {
    final Uri url = Uri.parse(_quoteUrl);
    final response = await http.get(url);
    print(response.body);
  }
}
