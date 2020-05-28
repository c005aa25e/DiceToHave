import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wurfel {
  // ez kell ide

  // itt kezdunk
  Wurfel({bool lathatosag=false}){
    lathato=lathatosag;
  }

  // a dobasok erteke
  int _ertek=4;
  int get ertek => _ertek;
  set ertek(int value) {
      if (value>=1 && value<=6) {
        _ertek = value;
      }
  }

  //az ikonok merete
  double ikonmeret=100.0;
  //lathatosag
  bool lathato;
  //igazitas
  MainAxisAlignment igazitas=MainAxisAlignment.center;

  //szinek
  Color hatterszin=Colors.white;
  Color pontszin=Colors.black;

  //veletlenszam-generator
  Random veletlenszamgenerator=Random();

  Color _milyenSzinuLegyek(int sor, int oszlop){
    Color szin=hatterszin;
    if (sor==0 && oszlop==0 && _ertek>=4){
      szin=pontszin;
    }
    //(sor==0 && oszlop==1) soha nem vilagit
    if (sor==0 && oszlop==2){
      if (_ertek!=1) {
        szin=pontszin;
      }
    }
    if (sor==1 && oszlop==0){
      if (_ertek==6) {
        szin=pontszin;
      }
    }
    if (sor==1 && oszlop==1){
      if (_ertek%2==1) {
        szin=pontszin;
      }
    }
    if (sor==1 && oszlop==2){
      if (_ertek==6) {
        szin=pontszin;
      }
    }
    if (sor==2 && oszlop==0){
      if (_ertek!=1) {
        szin=pontszin;
      }
    }
    //(sor==2 && oszlop==1) sosem
    if (sor==2 && oszlop==2){
      if (_ertek>=4) {
        szin=pontszin;
      }
    }
    return szin;
  }

  void novel() {
    _ertek=((_ertek++==7)?1:_ertek);
  }

  void csokkent() {
    _ertek=((_ertek--==0)?6:_ertek);
  }

  void dobas() {
    _ertek=veletlenszamgenerator.nextInt(6)+1;
  }

  Widget getWidget(BuildContext context) {
    if (!lathato) return  Column();
    return Container(

      child: Stack(
         fit:StackFit.expand,
           children: <Widget>[
            Text(MediaQuery.of(context).size.width.toString()),
            Text(MediaQuery.of(context).size.height.toString()),
           /* Positioned (
              top:10.0,
              left:10.0,
              height:330.0,
              width:330.0,
              child:Container(
                 color: Colors.grey,
              ),
            ),*/
            Positioned(
                 top: 0.0,
                 left: 0.0,
                 height: ikonmeret,
                 width: ikonmeret,
                 child: Icon(Icons.fiber_manual_record,size:ikonmeret,color:_milyenSzinuLegyek(0, 0))
                  ),
           /*  Positioned(
                 top: 0.0,
                 left: 100.0,
                 height: ikonmeret,
                 width: ikonmeret,
                 child: Icon(Icons.fiber_manual_record,size:ikonmeret,color:_milyenSzinuLegyek(0, 1))
             ),
             Positioned(
                 top: 0.0,
                 left: 200.0,
                 height: ikonmeret,
                 width: ikonmeret,
                 child: Icon(Icons.fiber_manual_record,size:ikonmeret,color:_milyenSzinuLegyek(1, 0))
             ),
             Positioned(
                 top: 100.0,
                 left: 000.0,
                 height: ikonmeret,
                 width: ikonmeret,
                 child: Icon(Icons.fiber_manual_record,size:ikonmeret,color:_milyenSzinuLegyek(1, 0))
             ),
             Positioned(
                 top: 100.0,
                 left: 000.0,
                 height: ikonmeret,
                 width: ikonmeret,
                 child: Icon(Icons.fiber_manual_record,size:ikonmeret,color:_milyenSzinuLegyek(1, 0))
             ),*/
             ],
        )
    );
   }



}