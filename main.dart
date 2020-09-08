import 'package:flutter/material.dart';

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
  TextEditingController _controller;
  TextStyle _ts;
  GameType _gameType = const GameType("Basic");
  List<GameType> types = <GameType>[
    const GameType("Basic"),
    const GameType("Riichi"),
    const GameType("Chinese Official"),
  ];

  @override
  Widget build(BuildContext context) {
    _ts = Theme.of(context).textTheme.headline4;
    if (_state == AppState.setup) {
      return setup();
    } else if (_state == AppState.rules) {
      return rules();
    } else if (_state == AppState.calculator){
      return setup(); // Still returns to setup for now because the calculator page is not set up yet
    } else {
      return selection();
    }
  }

  Widget setup() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            button("Rules", AppState.rules),
            button("Odds Calculator", AppState.calculator)
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
    if (_gameType == const GameType("Basic")){
      rules = "Welcome to basic Mahjong, In order to win the game you need to be the first player to get a hand composed of four sets and a pair. A set can be composed of a group of 3 of the same tile, called a pung, a group of 4 of the same tile, called a kong, or a group of 3 consecutive numbers in the same suit.";
    } else if (_gameType == const GameType("Riichi")){
      rules = "Welcome to Riichi Mahjong!! No idea how to get all of the rules on a page so temporary statement";
    } else {
      rules = "Welcome to Chinese Official Mahjong!! No idea how to get all of the rules on a page so temporary statement";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
      ),
     backgroundColor: Colors.indigo,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<GameType>(
                value: _gameType,
              onChanged: (GameType newType) {
                  setState(() {
                    print("Type changed to" + newType.name);
                    _gameType = newType;
                  });
              },
              items: types.map((GameType gameType) {
                return DropdownMenuItem<GameType>(
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

  void _ChangeState(AppState state) {
    try {
      setState(() {
        _state = state;
      });
    } on FormatException {
      print("Exception Occured");
    }
  }
}

enum AppState {
  setup,
  selection,
  rules,
  calculator
}

class GameType {
  const GameType(this.name);
  final String name;
}