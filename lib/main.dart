import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        title: 'Question 3',
        home: QuoteScreen(),
      ),
    );

// You may not need to use all the classes.
// Modify any of the classes whenever necessary

class Author {
  String id;
  String name;

  Author({this.id, this.name});
  Author.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], name: json['name']);
}

class Category {
  String id;
  String title;

  Category({this.id, this.title});
  Category.fromJson(Map<String, dynamic> json)
      : this(id: json['id'], title: json['title']);
}

class Quote {
  int read;
  String authorId;
  String categoryId;
  String quote;
  int get length => quote != null ? quote.length : 0;

  // You may need the following attributes.
  // String authorName;
  // String categoryTitle;

  Quote({this.read = 0, this.authorId, this.categoryId, this.quote = ''});
  Quote.fromJson(Map<String, dynamic> json)
      : this(
            read: json['read'],
            authorId: json['author_id'],
            categoryId: json['category_id'],
            quote: json['quote']);
}

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('The title goes here')),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('The quote goes here',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.deepPurple,
                  )),
              SizedBox(
                height: 20,
              ),
              Text('Additional info about the quote goes here',
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
            ],
          ),
        ));
  }
}
