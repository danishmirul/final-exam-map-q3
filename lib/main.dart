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
  Quote quote = new Quote();
  Author author = new Author();

  Future get(String baseUrl) async {
    final response = await http.get('$baseUrl');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw response;
  }

  Future fetchData() async {
    final responseQuote = await http
        .get('https://run.mocky.io/v3/bb933fac-18fa-407d-bbe2-74f5699161bf/');

    final jsonQuote = jsonDecode(responseQuote.body);
    List<Quote> quotes = List<Quote>();

    for (int i = 0; i < jsonQuote['quotes'].length; i++) {
      Quote temp = Quote.fromJson(jsonQuote['quotes'][i]);
      if (temp.authorId == 'x9mali') quotes.add(temp);
    }

    Quote quote = new Quote();
    int reader = 0;
    quotes.forEach((element) {
      if (reader == 0) {
        reader = element.read;
        quote = element;
      } else if (element.read > reader) {
        reader = element.read;
        quote = element;
      }
    });

    return quote;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            quote = snapshot.data;
            return _buildMainScreen();
          }
          return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildMainScreen() {
    return Scaffold(
        appBar: AppBar(title: Text('Most Popular Quote By Author')),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(quote.quote,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.deepPurple,
                  )),
              SizedBox(
                height: 20,
              ),
              Text('This quote has been read ${quote.read} times',
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
            ],
          ),
        ));
  }

  Scaffold _buildFetchingDataScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Fetching data in progress'),
          ],
        ),
      ),
    );
  }
}
