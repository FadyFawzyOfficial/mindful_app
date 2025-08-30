import 'package:flutter/material.dart';

import 'db_helper.dart';
import 'quote.dart';

class QuoteListScreen extends StatelessWidget {
  const QuoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Favorite Quotes')),
      body: FutureBuilder(
        future: quotes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<ListTile> quoteListTiles = snapshot.data!
                .map(
                  (quote) => ListTile(
                    title: Text(quote.text),
                    subtitle: Text(quote.author),
                  ),
                )
                .toList();

            return ListView(children: quoteListTiles);
          }
        },
      ),
    );
  }

  Future<List<Quote>> get quotes => DbHelper().getQuotes();
}
