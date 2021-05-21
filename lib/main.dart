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
    //ez fut eloszor
    //legyartjuk a kockakat
    _table = t.Table(
        count:1,
        rotationEnabled: true);
    //egy kocka modban indulunk
    _egykocka();
  }

  t.Table _table;

  /*double _kockameret(double maxWidth, double maxHeight) {
    double m = maxWidth < maxHeight ? maxWidth : maxHeight;
    m = _k2.lathato ? m * 2 / 3 : m;
    return m;
  }*/
  bool _rotationEnabled=true;
  void _egykocka() {
  }

  void _ketkocka() {
  }

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
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _table.count--;
                      });
                    },
                    tooltip: 'Less',
                    child: Icon(Icons.remove),
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
        title: Text('Beállítások'),
      ),
      Container(
        margin: const EdgeInsets.all(10.0),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'Kockák száma: ' + _table.count.toString(),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                this._egykocka();
                Navigator.of(context).pop();
                SystemSound.play(SystemSoundType.click);
              });
            },
            tooltip: 'Egykocka',
            child: Icon(Icons.filter_1),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                this._ketkocka();
                Navigator.of(context).pop();
                SystemSound.play(SystemSoundType.click);
              });
            },
            tooltip: 'Kétkocka',
            child: Icon(Icons.filter_2),
          ),
        ],
      )),
      SwitchListTile(
        title: const Text('Random rotation'),
        value: _rotationEnabled,
        onChanged: (bool value) {
          setState(() {
            _table.rotationEnabled=value;
            Navigator.of(context).pop();
            SystemSound.play(SystemSoundType.click);
          });
        },
        secondary: const Icon(Icons.loop),
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
