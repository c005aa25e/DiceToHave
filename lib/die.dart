import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Class representing a die rendered in its available space
class Die {
  /// Static variable to store the dots on one die
  final dots = <Widget>[];

  ///The actual value of the dice. It defaults to 4, but a random is called right after initialization.
  int _value = 4;

  ///Returns the actual value of the dice.
  int get value => _value;

  ///Sets the value of the dice. Accepted values: 1-6, otherwise ignored.
  set value(int value) {
    if (value >= 1 && value <= 6) {
      _value = value;
    }
  }

  ///Alignment of the dice
  MainAxisAlignment alignment = MainAxisAlignment.center;

  ///Background color
  Color bgColor = Colors.white;

  ///The color of the dots
  Color dotColor = Colors.black;

  ///Random-generator
  Random rndGenerator = Random();

  ///Returns the color of the dots.
  ///
  /// It uses [_value] to determine if a dot in [row] row and [col] column is highlighted or not.
  /// If highlighted, returns [dotColor], otherwise [bgColor].
  bool _isDotVisible(int row, int col) {
    bool retVal=false;
    if (
      (row == 0 && col == 0 && _value >= 4) ||
      (row == 0 && col == 2 && _value != 1) ||
      (row == 1 && col == 0 && _value == 6) ||
      (row == 1 && col == 1 && _value % 2 == 1) ||
      (row == 1 && col == 2 && _value == 6) ||
      (row == 2 && col == 0 && _value != 1) ||
      (row == 2 && col == 2 && _value >= 4))
        retVal=true;
    return retVal;
  }

  ///Throws the dice (assigns a random number to [_value])
  void doRoll() {
    _value = rndGenerator.nextInt(6) + 1;
  }

  ///Calculates the top coordinate of a dot in [row] row and [col] column.
  double _dotTop(int row, int col) {
    return _dotSize * (row + 0.25) + (_availableHeight-_innerSize)/2;
  }

  ///Calculates the left coordinate of a dot in [row] row and [col] column.
  double _dotleft(int row, int col) {
    return _dotSize * (col + 0.25) + (_availableWidth-_innerSize)/2;
  }

  /// If true, the dice will be smaller to be able to rotate in the box. It rotates after every [dobas()]
  bool rotation=true;
  bool randomPosition=false;

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

  /// in case of random position the random offset from left
  double _leftOffset=0;

  ///In case of random position the random offset from top
  double _topOffset=0;

  ///Calculates the size of the dice based on the available place
  void _setSize(double width, double height){
    _availableWidth=width;
    _availableHeight=height;
    _outerSize=(_availableWidth<_availableHeight?_availableWidth:_availableHeight);
    _outerSize=(randomPosition?_outerSize/3:_outerSize);
    _innerSize=(rotation?_outerSize/1.5:_outerSize/1.1);
    _leftOffset=(randomPosition?rndGenerator.nextDouble()*_outerSize/2:0);
    _topOffset=(randomPosition?rndGenerator.nextDouble()*_outerSize/2:0);
    _dotSize=_innerSize/3.5;
  }

  ///Assigns a random number to the rotation angle
  double getRandomRotationAngle(){
    return (rotation?rndGenerator.nextInt(360)/2/pi:0);
  }

  ///returns the Widget code to display. [context] informs the calculations about the available space.
  Widget getDieWidget(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          _setSize(constraints.maxWidth,constraints.maxHeight);
          _renderDots();
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
  void _renderDots()
  {
    dots.clear();
    dots.add(Positioned(
      top: (_availableHeight-_innerSize)/2+_topOffset,
      left: (_availableWidth-_innerSize)/2+_leftOffset,
      height: _innerSize,
      width: _innerSize,
      child: Container(
        decoration:BoxDecoration(
          border: Border.all(
              width: _dotSize/10
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(_dotSize/3) //         <--- border radius here
          ),
        )
      )));
    for (var row = 0; row < 3; row++) {
      for (var col = 0; col < 3; col++) {
        if (_isDotVisible(row,col)) {
          dots.add(Positioned(
          top: _dotTop(row,col)+_topOffset,
          left: _dotleft(row,col)+_leftOffset,
          height: _dotSize,
          width: _dotSize,
          child: Icon(Icons.fiber_manual_record,
          size: _dotSize, color: dotColor)));
        }
      }
    }
  }

  ///Constructor for the class.
  Die() {
    doRoll();
  }
}
