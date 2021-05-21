import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Class representing a die rendered in its available space
class Die {
  /// Static variable to store the dots on one die
  final dots = <Widget>[];


  //lathatosag
  /// If True, the cube is visible, otherwise not rendered.
  bool visible;

  // a dobasok erteke
  ///The actual value of the dice. It defaults to 4, but a random is called after initialization.
  int _ertek = 4;

  ///Returns the actual value of the dice.
  int get ertek => _ertek;

  ///Sets the value of the dice. Accepted values: 1-6, otherwise ignored.
  set ertek(int value) {
    if (value >= 1 && value <= 6) {
      _ertek = value;
    }
  }

  //igazitas
  ///Alignment of the dice
  MainAxisAlignment igazitas = MainAxisAlignment.center;

  //szinek
  ///Background color
  Color hatterszin = Colors.white;
  ///The color of the dots
  Color pontszin = Colors.black;

  //veletlenszam-generator
  ///Random-generator
  Random veletlenszamgenerator = Random();

  ///Returns the color of the dots.
  ///
  /// It uses [_ertek] to determine if a dot in [sor] row and [oszlop] column is highlighted or not.
  /// If highlighted, returns [pontszin], otherwise [hatterszin].
  bool _isDotVisible(int sor, int oszlop) {
    bool retVal=false;
    if (
      (sor == 0 && oszlop == 0 && _ertek >= 4) ||
      (sor == 0 && oszlop == 2 && _ertek != 1) ||
      (sor == 1 && oszlop == 0 && _ertek == 6) ||
      (sor == 1 && oszlop == 1 && _ertek % 2 == 1) ||
      (sor == 1 && oszlop == 2 && _ertek == 6) ||
      (sor == 2 && oszlop == 0 && _ertek != 1) ||
      (sor == 2 && oszlop == 2 && _ertek >= 4))
        retVal=true;
    return retVal;
  }

  ///Throws the dice (assigns a random number to [_ertek])
  void doRoll() {
    _ertek = veletlenszamgenerator.nextInt(6) + 1;
  }

  ///Calculates the top coordinate of a dot in [sor] row and [oszlop] column.
  double _pottyTop(int sor, int oszlop) {
    return _dotSize * (sor + 0.25) + (_availableHeight-_innerSize)/2;
  }

  ///Calculates the left coordinate of a dot in [sor] row and [oszlop] column.
  double _pottyLeft(int sor, int oszlop) {
    return _dotSize * (oszlop + 0.25) + (_availableWidth-_innerSize)/2;
  }

  /// If true, the dice will be smaller to be able to rotate in the box. It rotates after every [dobas()]
  bool rotation=true;

  ///The outer size of the dice (square around)
  double _outerSize=0;
  ///The inner size of the dice (placeholder for dots)
  double _innerSize=0;
  ///The size of the dots
  double _dotSize=0;
  ///The available width to display the dice on the screen
  double _availableWidth=0;
  ///The available height to display the dice on the screen
  double _availableHeight=0;

  ///Calculates the size of the dice based on the available place
  void _setSize(double width, double height){
    _availableWidth=width;
    _availableHeight=height;
    _outerSize=(_availableWidth<_availableHeight?_availableWidth:_availableHeight);
    _innerSize=(rotation?_outerSize/1.5:_outerSize/1.1);
    _dotSize=_innerSize/3.5;
  }

  ///Assigns a random number to the rotation angle
  double getRandomRotationAngle(){
    return (rotation?veletlenszamgenerator.nextInt(360)/2/pi:0);
  }

  ///returns the Widget code to display. [context] informs the calculations about the available space.
  Widget getDieWidget(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          _setSize(constraints.maxWidth,constraints.maxHeight);
          _pottyoz();
          return Transform.rotate(
                angle: getRandomRotationAngle(),
                child: Stack(
                    children: dots
                )
          );
        }
    );
  }

  ///Renders the dots on the dice
  void _pottyoz()
  {
    dots.clear();
    dots.add(Positioned(
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
        if (_isDotVisible(sor,oszlop)) {
          dots.add(Positioned(
          top: _pottyTop(sor,oszlop),
          left: _pottyLeft(sor,oszlop),
          height: _dotSize,
          width: _dotSize,
          child: Icon(Icons.fiber_manual_record,
          size: _dotSize, color: pontszin)));
        }
      }
    }
  }

  ///Constructor for the class. If [lathatosag] is true, it is visible, otherwise not rendered.
  Die() {
    doRoll();
  }
}
