import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/animallist.dart';
import 'package:flutter_app/imagePick.dart';
import 'package:flutter_app/locationTest.dart';
import 'package:flutter_app/photohero.dart';
import 'package:flutter_app/sharepreference.dart';

import 'cq/login.dart';
import 'second.dart';
import 'third.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Welcome to Flutter',
      home: Randoms(),
      theme: ThemeData(primaryColor: Colors.white),
      routes: {
        "/second": (context) => Second(),
        "/third": (BuildContext context) => Third(),
        "/login": (BuildContext context) => Login()
      },
    ),
  );
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
    Navigator.of(context).pushNamed("/third");
  }

  void _jumpFour() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Third();
    }));
  }

  void _jumpLogin() {
    Navigator.of(context).pushNamed("/login");
  }

  void _jumpLocation() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LocationTest();
    }));
  }

  void _jumpImagePick() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ImagePick();
    }));
  }

  void _jumpSharePreference() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SharePreference();
    }));
  }

  void _jumpAnimal() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LogoAnimal();
    }));
  }

  void _jumpHero() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("PhotoHero"),
        ),
        body: Container(
          color: Colors.transparent,
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.topLeft,
          child: PhotoHero(
            photo: "asset/images/ic_launcher.png",
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    var widgetes = [
      FlatButton(
        onPressed: _jumpSecond,
        child: Text("Second"),
        splashColor: Colors.purple,
      ),
      RawMaterialButton(
        fillColor: Colors.grey,
        highlightColor: Colors.red,
        onPressed: _jumpThird,
        elevation: 5,
        child: Text("Third"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            side: BorderSide(width: 1, style: BorderStyle.solid)),
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
      ),
      RaisedButton(
        onPressed: _jumpLogin,
        child: Text(
          "Login",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        elevation: 5,
        highlightElevation: 7,
        highlightColor: Colors.black38,
      ),
      RaisedButton(
        onPressed: _jumpLocation,
        child: Text(
          "Location",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        elevation: 5,
        highlightElevation: 7,
        highlightColor: Colors.black38,
      ),
      RaisedButton(
        onPressed: _jumpImagePick,
        child: Text(
          "ImagePick",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        elevation: 5,
        highlightElevation: 7,
        highlightColor: Colors.black38,
      ),
      RaisedButton(
        onPressed: _jumpSharePreference,
        child: Text(
          "SharedPreference",
          style: TextStyle(fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
        elevation: 5,
        highlightElevation: 7,
        highlightColor: Colors.black38,
      ),
      RaisedButton(
        onPressed: _jumpAnimal,
        child: Text(
          "AnimalList",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        elevation: 5,
        highlightElevation: 7,
        highlightColor: Colors.black38,
      ),
      RaisedButton(
        child: PhotoHero(
          photo: "asset/images/ic_launcher.png",
          width: 200,
          onTap: _jumpHero,
        ),
        elevation: 5,
        highlightElevation: 7,
        highlightColor: Colors.black38,
      ),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text("Suggestion Name"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.list), onPressed: _press)
          ],
        ),
        body: GridView.builder(
            itemCount: widgetes.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5.0, crossAxisSpacing: 5.0, crossAxisCount: 3),
            itemBuilder: (context, postion) {
              return widgetes[postion];
            }));
  }
}
