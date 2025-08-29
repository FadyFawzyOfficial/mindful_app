import 'dart:convert';

class Quote {
  final String text;
  final String author;

  Quote({required this.text, required this.author});

  factory Quote.fromMap(Map<String, dynamic> map) =>
      Quote(text: map['text'] ?? '', author: map['author'] ?? '');

  factory Quote.fromJson(String source) => Quote.fromMap(json.decode(source));
}
