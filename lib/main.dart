import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'second.dart';
import 'third.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Randoms(),
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}

class Randoms extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RandomsState();
}

class _RandomsState extends State<Randoms> {
  final _suggestions = <WordPair>[];
  final _biggerText = TextStyle(fontSize: 16.0);
  final _saved = Set<WordPair>();

  Widget _buildRow(WordPair pair) {
    final _isSaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerText,
      ),
      trailing: Icon(_isSaved ? Icons.favorite : Icons.favorite_border,
          color: _isSaved ? Colors.red : null),
      onTap: () {
        setState(() {
          if (_isSaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return Divider(
              height: 1.0,
              color: Colors.grey[900],
            );
          }
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  _press() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final items = _saved.map((pair) => ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerText,
            ),
          ));
      final divides =
          ListTile.divideTiles(context: context, tiles: items).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text("Save Suggestions Name"),
        ),
        body: ListView(
          children: divides,
        ),
      );
    }));
  }

  void _jumpSecond() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SecondApp();
    }));
  }

  void _jumpThird() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Third();
    }));
  }

  void _jumpFour() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Third();
    }));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Suggestion Name"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _press)
        ],
      ),
      body: Row(
        children: [
          FlatButton(
            onPressed: _jumpSecond,
            child: Text("Second"),
            splashColor: Colors.purple,
          ),
          RawMaterialButton(
            highlightColor: Colors.red,
            onPressed: _jumpThird,
            elevation: 5,
            child: Text("Third"),
          ),
          RaisedButton(
            onPressed: _jumpFour,
            child: Text(
              "Four",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            elevation: 5,
            highlightElevation: 7,
            highlightColor: Colors.black38,
          )
        ],
      ),
    );
  }
}
