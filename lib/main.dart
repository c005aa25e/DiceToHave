import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'table.dart' as t;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This is the root of the application.
  final String _appName='Dice2Have';
  final Color _mainColor=Colors.yellow;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: this._appName,
      theme: ThemeData(
        primarySwatch: this._mainColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: this._appName),
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
  _MyHomePageState() {
    //this runs first
    //creating the table
    _table = t.Table(
        diceCount:1,
        rotationEnabled: _rotationEnabled,
        randomPosition: _randomPosition);
  }

  ///Table, where the dice will be rendered
  t.Table _table;

  ///Enabling rotation of dice
  bool _rotationEnabled=true;

  ///Enabling random position for the dice. The dice will be smaller, and random position in the middle of their own box.
  bool _randomPosition=false;
  ///Closing the menu
  void _exitTapped(){
    SystemNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget
            .title + '      < ' + _table.getSumOfValues().toString() + ' >'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
                child: _table.getWidget(context)
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _table.count++;
                      });
                    },
                    tooltip: 'More',
                    child: Icon(Icons.add),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _table.doRoll();
                      });
                    },
                    tooltip: 'Roll',
                    child: Icon(Icons.fingerprint),
                  ),
                  InkWell(
                    child: FloatingActionButton(
                    tooltip: 'Less',
                    child: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          _table.count--;
                        });
                      },
                    ),
                    onLongPress: () { //todo: it definitely fails in virtual environment
                      setState(() {
                        _table.count=1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
      drawer: Drawer(
        child: Column(
            children: <Widget>[
        AppBar(
        title: Text('Customize'),
      ),
      Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'Count of dice: ' + _table.count.toString(),
          ),
        ],
      )),
      SwitchListTile(
        title: const Text('Random rotation'),
        value: _rotationEnabled,
        onChanged: (bool value) {
          setState(() {
            _rotationEnabled=value;
            _table.rotationEnabled=_rotationEnabled;
            Navigator.of(context).pop();
            SystemSound.play(SystemSoundType.click);
          });
        },
        secondary: const Icon(Icons.loop),
      ),
      SwitchListTile(
        title: const Text('Random position'),
        value: _randomPosition,
        onChanged: (bool value) {
          setState(() {
            _randomPosition=value;
            _table.randomPosition=_randomPosition;
            Navigator.of(context).pop();
            SystemSound.play(SystemSoundType.click);
          });
        },
        secondary: const Icon(Icons.loop),
      ),
      ListTile(
        leading: Icon(Icons.looks_one),
        title: Text("One die only"),
        dense:false,
        onTap: (){
          setState(() {
            _table.count=1;
            Navigator.of(context).pop();
            SystemSound.play(SystemSoundType.click);
          });
        },
      ),
      ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("Exit"),
        dense:false,
        onTap: _exitTapped,
      ),
      ],
    ),)
    ,
    );
  }
}
