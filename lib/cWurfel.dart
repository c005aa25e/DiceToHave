import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wurfel {
  // ez kell ide
  final pottyok = <Widget>[];

  // itt kezdunk

  //lathatosag
  bool lathato;

  // a dobasok erteke
  int _ertek = 4;

  int get ertek => _ertek;

  set ertek(int value) {
    if (value >= 1 && value <= 6) {
      _ertek = value;
    }
  }

  //az ikonok merete
  double meret = 100.0;

  //igazitas
  MainAxisAlignment igazitas = MainAxisAlignment.center;

  //szinek
  Color hatterszin = Colors.white;
  Color pontszin = Colors.black;

  //veletlenszam-generator
  Random veletlenszamgenerator = Random();

  Color _milyenSzinuLegyek(int sor, int oszlop) {
    Color szin = hatterszin;
    if (sor == 0 && oszlop == 0 && _ertek >= 4) {
      szin = pontszin;
    }
    //(sor==0 && oszlop==1) soha nem vilagit
    if (sor == 0 && oszlop == 2) {
      if (_ertek != 1) {
        szin = pontszin;
      }
    }
    if (sor == 1 && oszlop == 0) {
      if (_ertek == 6) {
        szin = pontszin;
      }
    }
    if (sor == 1 && oszlop == 1) {
      if (_ertek % 2 == 1) {
        szin = pontszin;
      }
    }
    if (sor == 1 && oszlop == 2) {
      if (_ertek == 6) {
        szin = pontszin;
      }
    }
    if (sor == 2 && oszlop == 0) {
      if (_ertek != 1) {
        szin = pontszin;
      }
    }
    //(sor==2 && oszlop==1) sosem
    if (sor == 2 && oszlop == 2) {
      if (_ertek >= 4) {
        szin = pontszin;
      }
    }
    return szin;
  }

  void novel() {
    _ertek = ((++_ertek > 6) ? 1 : _ertek);
  }

  void csokkent() {
    _ertek=(--_ertek < 1?6:_ertek);
  }

  void dobas() {
    _ertek = veletlenszamgenerator.nextInt(6) + 1;
  }


  double _pottyTop(int sor, int oszlop) {
    return _dotSize * (sor + 0.25) + (_availableHeight-_innerSize)/2;
  }

  double _pottyLeft(int sor, int oszlop) {
    return _dotSize * (oszlop + 0.25) + (_availableWidth-_innerSize)/2;
  }

  bool _rotation=true;

  bool get rotation => _rotation;

  set rotation(bool value) {
    _rotation = value;
  }

  double _outerSize=0;
  double _innerSize=0;
  double _dotSize=0;
  double _availableWidth=0;
  double _availableHeight=0;

  void _setSize(double width, double height){
    _availableWidth=width;
    _availableHeight=height;
    _outerSize=(_availableWidth<_availableHeight?_availableWidth:_availableHeight);
    _innerSize=(_rotation?_outerSize/1.5:_outerSize/1.1);
    _dotSize=_innerSize/3.5;
  }
  double getRandomRotationAngle(){
    return (_rotation?veletlenszamgenerator.nextInt(360)/2/pi:0);
  }
  Widget getWidget(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          _setSize(constraints.maxWidth,constraints.maxHeight);
          _pottyoz();
          return Transform.rotate(
                angle: getRandomRotationAngle(),
                child: Stack(
                    children: pottyok
                )
          );
        }
    );
  }

  void _pottyoz()
  {
    pottyok.clear();
    pottyok.add(Positioned(
      top: (_availableHeight-_innerSize)/2,
      left: (_availableWidth-_innerSize)/2,
      height: _innerSize,
      width: _innerSize,
      child: Container(
        decoration:BoxDecoration(
          border: Border.all(
              width: 3.0
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(_dotSize/3) //         <--- border radius here
          ),
        )
      )));
    for (var sor = 0; sor < 3; sor++) {
      for (var oszlop = 0; oszlop < 3; oszlop++) {
        pottyok.add(Positioned(
            top: _pottyTop(sor,oszlop),
            left: _pottyLeft(sor,oszlop),
            height: _dotSize,
            width: _dotSize,
            child:  Icon(Icons.fiber_manual_record,
                size: _dotSize, color: _milyenSzinuLegyek(sor, oszlop))));
      }
    }
  }


  Wurfel({bool lathatosag = false}) {
    lathato = lathatosag;

  }
}
