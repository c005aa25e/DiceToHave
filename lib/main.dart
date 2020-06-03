import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'cWurfel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dobókocka',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Dobókocka'),
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
  _MyHomePageState(){
    //ez fut eloszor
    //legyartjuk a kockakat
    _k1=Wurfel(lathatosag:false);
    _k2=Wurfel(lathatosag:false);
    //egy kocka modban indulunk
    _egykocka();
  }

  Wurfel _k1;
  Wurfel _k2;

  void _egykocka() {
      _k1.ikonmeret=100.0;
      _k2.ikonmeret=100.0;
      _k1.lathato=true;
      _k2.lathato=false;
      _k1.igazitas=MainAxisAlignment.center;
  }
  void _ketkocka() {
      _k1.ikonmeret=50.0;
      _k2.ikonmeret=50.0;
      _k1.lathato=true;
      _k2.lathato=true;
      _k1.igazitas=MainAxisAlignment.end;
      _k2.igazitas=MainAxisAlignment.start;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title + ' ' + (((_k1.lathato)?_k1.ertek:0) + ((_k2.lathato)?_k2.ertek:0)).toString()),
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('maci'),
              Expanded(child:_k1.getWidget(context)),

             // _k2.getWidget(context),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  onPressed:  (){
                    setState(() {
                      _k1.novel();
                      _k2.novel();
                    });
                    },
                  tooltip: 'Növel',
                  child: Icon(Icons.add),
                ),FloatingActionButton(
                  onPressed: (){
                    setState(() {
                      _k1.dobas();
                      _k2.dobas();
                    });
                    },
                  tooltip: 'Véletlen',
                  child: Icon(Icons.fingerprint),
                ),
                FloatingActionButton(
                  onPressed: (){
                    setState(() {
                      _k1.csokkent();
                      _k2.csokkent();
                    });
                    },
                  tooltip: 'Csökken',
                  child: Icon(Icons.remove),
                ),
              ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('Kockák száma: ' + ((_k1.lathato?1:0) + (_k2.lathato?1:0)).toString(),
                ),
              FloatingActionButton(
                onPressed: (){setState(() {
                   this._egykocka();
                   Navigator.of(context).pop();
                   SystemSound.play(SystemSoundType.click);
                  });},
                tooltip: 'Egykocka',
                child: Icon(Icons.filter_1),
              ),
              FloatingActionButton(
                onPressed: (){setState(() {
                   this._ketkocka();
                   Navigator.of(context).pop();
                   SystemSound.play(SystemSoundType.click);
                  });},
                tooltip: 'Kétkocka',
                child: Icon(Icons.filter_2),
              ),
            ],
          ),
        ],
        ),

      ),
    );
  }


}
