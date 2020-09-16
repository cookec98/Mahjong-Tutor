import 'package:flutter/material.dart';

import 'package:mahjong_tutor/sorter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahjong Tutor',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Mahjong Tutor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AppState _state = AppState.setup;
  AppState _nextState = AppState.setup;
  TextStyle _ts;
  String tileString = '';
  String handInfo = "";
  List tiles = [];
  Type _gameType = const Type("Basic");
  Type tileType = const Type("Dot");
  Type tileNumber = const Type("1");
  List<Type> mahjongTypes = <Type>[
    const Type("Basic"),
    const Type("Riichi"),
    const Type("Chinese Official"),
  ];
  List<Type> tileTypes = <Type>[
    const Type("Dot"),
    const Type("Bam"),
    const Type("Crack"),
    const Type("Red Dragon"),
    const Type("Green Dragon"),
    const Type("White Dragon"),
    const Type("North"),
    const Type("East"),
    const Type("South"),
    const Type("West")
  ];
  List<Type> numbers = [
    const Type("1"),
    const Type("2"),
    const Type("3"),
    const Type("4"),
    const Type("5"),
    const Type("6"),
    const Type("7"),
    const Type("8"),
    const Type("9"),
    ];

  @override
  Widget build(BuildContext context) {
    _ts = Theme.of(context).textTheme.headline4;
    if (_state == AppState.setup) {
      return setup();
    } else if (_state == AppState.rules) {
      return rules();
    } else if (_state == AppState.calculator){
      return calculator(); // Still returns to setup for now because the calculator page is not set up yet
    } else {
      return selection();
    }
  }

  Widget setup() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.indigo,
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            button("Rules", AppState.rules),
            button("Hand Sorter", AppState.calculator)
          ],
      ),
    ),
    );
  }

  Widget button(String label, AppState state) {
    return RaisedButton(child: Text(label, style: _ts), onPressed: () {_ChangeState(AppState.selection);_nextState = state;});
  }

  Widget rules() {
    String rules = "";
    if (_gameType == const Type("Basic")){
      rules = "Welcome to basic Mahjong, In order to win the game you need to be the first player to get a hand composed of four sets and a pair. A set can be composed of a group of 3 of the same tile, called a pung, a group of 4 of the same tile, called a kong, or a group of 3 consecutive numbers in the same suit.";
    } else if (_gameType == const Type("Riichi")){
      rules = "Welcome to Riichi Mahjong!! Only basic is currently implemented";
    } else {
      rules = "Welcome to Chinese Official Mahjong!! Only basic is currently implemented";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // https://medium.com/flutterpub/playing-with-appbar-in-flutter-3a8abd9b982a#:~:text=Flutter%20allow%20you%20to%20create,left%20side%20of%20the%20Appbar.
        leading: GestureDetector(
          onTap: () { _ChangeState(AppState.selection); },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      backgroundColor: Colors.indigo,
        body: Center(
            child: Column (
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row (
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                      Flexible(
                        child: new Text(rules, style: _ts),
                      )
                  ]
                )
              ]
    )
    )
    );
  }

  Widget selection() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: GestureDetector(
          onTap: () { _ChangeState(AppState.setup); },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
     backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<Type>(
                value: _gameType,
              onChanged: (Type newType) {
                  setState(() {
                    print("Type changed to " + newType.name);
                    _gameType = newType;
                  });
              },
              items: mahjongTypes.map((Type gameType) {
                return DropdownMenuItem<Type>(
                  value: gameType,
                  child: Row(
                    children: <Widget>[
                      Text(gameType.name, style: _ts),
                    ],
                ),
                );
              }
              ).toList(),
            ),
            RaisedButton(child: Text("Confirm", style: _ts), onPressed: () {_ChangeState(_nextState);})
          ]
        )
      )
    );
  }

  Widget calculator(){
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: GestureDetector(
            onTap: () { _ChangeState(AppState.setup); },
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        backgroundColor: Colors.indigo,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: new Text(tileString, style: TextStyle(height: 2, fontSize: 20)),
                  ),
                  DropdownButton<Type>(
                    value: tileType,
                    onChanged: (Type newType) {
                      setState(() {
                        print("Type changed to " + newType.name);
                        tileType = newType;
                      });
                    },
                    items: tileTypes.map((Type tileType) {
                      return DropdownMenuItem<Type>(
                        value: tileType,
                        child: Row(
                          children: <Widget>[
                            Text(tileType.name, style: _ts),
                          ],
                        ),
                      );
                    }
                    ).toList(),
                  ),
                  DropdownButton<Type>(
                    value: tileNumber,
                    onChanged: (Type newType) {
                      setState(() {
                        print("Type changed to " + newType.name);
                        tileNumber = newType;
                      });
                    },
                    items: numbers.map((Type tileSelected) {
                      return DropdownMenuItem<Type>(
                        value: tileSelected,
                        child: Row(
                          children: <Widget>[
                            Text(tileSelected.name, style: _ts),
                          ],
                        ),
                      );
                    }
                    ).toList(),
                  ),
                  RaisedButton(child: Text("Add Tile", style: _ts), onPressed: () {addTile(tileType, tileNumber, tiles); print(tileString); setState(() {});} ),
                  RaisedButton(child: Text("Remove Tile", style: _ts), onPressed: () {if (tiles.length > 0){tiles.removeLast();} tileString = tileList(tiles);setState(() {});} ),
                  RaisedButton(child: Text("Sort", style: _ts), onPressed: () {tiles = sortHand(tiles); handInfo = tiles[tiles.length - 1];tiles.removeLast();tileString = tileList(tiles);setState(() {});} ),
                  Flexible(
                    child: new Text(handInfo, style: TextStyle(height: 2, fontSize: 20)),
                  ),
                ]
            )
        )
    );
  }

  List addTile(Type tileType, Type tileNumber, List tiles){
    if (tiles.length < 14) {
      if (tileType.name == "Dot" || tileType.name == "Bam" ||
          tileType.name == "Crack") {
        tiles.add(tileNumber.name + " " + tileType.name);
      } else {
        tiles.add(tileType.name);
      }
    }
    tileString = tileList(tiles);
    print(tiles.toString());
  }

  String tileList(List tiles) {
    String tileString = "";
    for (int i = 0;i < tiles.length;i++) {
      tileString += tiles[i] + ", ";
    }
    return tileString;
  }


  void _ChangeState(AppState state) {
    try {
      setState(() {
        _state = state;
      });
    } on FormatException {
      print("Exception Occurred");
    }
  }
}

enum AppState {
  setup,
  selection,
  rules,
  calculator
}

class Type {
  const Type(this.name);
  final String name;
}


