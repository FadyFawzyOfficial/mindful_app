import 'dart:convert';

class Quote {
  int? id;
  final String text;
  final String author;

  Quote({required this.text, required this.author});

  factory Quote.fromMap(Map<String, dynamic> map) =>
      Quote(text: map['q'] ?? '', author: map['a'] ?? '');

  Map<String, dynamic> toMap() => {'q': text, 'a': author};

  factory Quote.fromJson(String source) =>
      Quote.fromMap((json.decode(source))[0]);
}
