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
    _ertek = ((_ertek++ == 7) ? 1 : _ertek);
  }

  void csokkent() {
    _ertek = ((_ertek-- == 0) ? 6 : _ertek);
  }

  void dobas() {
    _ertek = veletlenszamgenerator.nextInt(6) + 1;
  }

  double _pottyMeret() {
    return meret / 4;
  }

  double _pottyTop(int sor, int oszlop) {
    return _pottyMeret() * (sor + 0.5);
  }

  double _pottyLeft(int sor, int oszlop) {
    return _pottyMeret() * (oszlop + 0.5);
  }

  Widget getWidget(BuildContext context, double meret) {
    this.meret=meret;
    if (!lathato) return Column();
    _pottyoz();
    return Container(
        child: Stack(
      fit: StackFit.passthrough ,
      children: pottyok,

    ),
      transform: Matrix4.rotationZ(0.05),
      width: meret,
      height: meret,
    );
  }

  _pottyoz(){
    pottyok.clear();

    pottyok.add(Positioned(
      top: _pottyMeret()*0.5,
      left: _pottyMeret()*0.5,
      height: _pottyMeret()*3,
      width: _pottyMeret()*3,
      child: Container(
        decoration:BoxDecoration(
          border: Border.all(
              width: 3.0
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(_pottyMeret()/3) //         <--- border radius here
          ),
        )
      )));


    for (var sor = 0; sor < 3; sor++) {
      for (var oszlop = 0; oszlop < 3; oszlop++) {
        pottyok.add(Positioned(
            top: _pottyTop(sor,oszlop),
            left: _pottyLeft(sor,oszlop),
            height: _pottyMeret(),
            width: _pottyMeret(),
            child:  Icon(Icons.fiber_manual_record,
                size: _pottyMeret(), color: _milyenSzinuLegyek(sor, oszlop))));
      }
    }
  }


  Wurfel({bool lathatosag = false}) {
    lathato = lathatosag;

  }
}
