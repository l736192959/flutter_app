import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class SecondApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Second(),
        theme: ThemeData(primaryColor: Colors.black),
      );
}

class Second extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    Column buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: color,
          ),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
            ),
          ),
        ],
      );
    }

    Widget titleSection = Container(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Oeschinen Lake Campground",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                'Kandersteg, Switzerland',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ],
          )),
          Favorite()
        ],
      ),
    );

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildButtonColumn(Icons.call, "Call"),
          buildButtonColumn(Icons.near_me, "Route"),
          buildButtonColumn(Icons.share, "Share"),
        ],
      ),
    );

    Widget textSection = Container(
      padding: EdgeInsets.all(32.0),
      child: Text(
        '"Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run."',
        softWrap: true,
      ),
    );

    Widget imageSection = Image.asset(
      "asset/images/image.jpg",
      height: 240.0,
      fit: BoxFit.cover,
    );
    List<Container> _buildGridTileList(int count) {
      return new List<Container>.generate(
          count,
          (int index) =>
              new Container(child: new Image.asset('asset/images/image.jpg')));
    }

    Widget buildGrid() {
      return new GridView.extent(
          scrollDirection: Axis.horizontal,
          maxCrossAxisExtent: 150.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          children: _buildGridTileList(30));
    }

    var stack = new Stack(
      alignment: const Alignment(0, 0),
      children: [
        CircleAvatar(
          backgroundImage: new AssetImage('asset/images/image.jpg'),
          radius: 100.0,
        ),
        Container(
          decoration: new BoxDecoration(
            color: Colors.black45,
          ),
          child: new Text(
            'Mia B',
            style: new TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );

    var card = new SizedBox(
      height: 210.0,
      child: new Card(
        child: new Column(
          children: [
            new ListTile(
              title: new Text('1625 Main Street',
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              subtitle: new Text('My City, CA 99984'),
              leading: new Icon(
                Icons.restaurant_menu,
                color: Colors.blue[500],
              ),
            ),
            new Divider(),
            new ListTile(
              title: new Text('(408) 555-1212',
                  style: new TextStyle(fontWeight: FontWeight.w500)),
              leading: new Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
            ),
            new ListTile(
              title: new Text('costa@example.com'),
              leading: new Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
              ),
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Second"),
      ),
      body: ListView(
        children: [imageSection, titleSection, buttonSection, textSection],
      ),
//      body: buildGrid(),
    );
  }
}

class Favorite extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoriteState();
  }
}

class _FavoriteState extends State<Favorite> {
  var _count = 41;
  var _isFavorite = true;
  void _favoritePress() {
    setState(() {
      if (_isFavorite) {
        _count -= 1;
        _isFavorite = false;
      } else {
        _count += 1;
        _isFavorite = true;
      }
    });
  }

  Widget _buildBody() {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red[900] : null,
              ),
              onPressed: _favoritePress),
          SizedBox(
            width: 18.0,
            child: Container(
              child: Text("$_count"),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => _buildBody();
}
