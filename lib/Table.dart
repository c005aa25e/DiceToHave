import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Table {
  List<Widget> _dices;
  /// Static variable to store the dots on the dice
  ///returns the Widget code to display. [context] informs the calculations about the available space.
  Widget getWidget(BuildContext context,{diceCount=1}) {
    return LayoutBuilder(
        builder: (context, constraints){
          for (int i=0;i<diceCount;i++) {
            _dices.add(Positioned(
                top: (i.toDouble()+1)*10,
                left: (i.toDouble()+1)*10,
                height: (i.toDouble()+1)*10,
                width: (i.toDouble()+1)*10,
                child: Placeholder()
            ));
          }
          return Stack(
              children: _dices
         );
      }
    );
  }

  void doThrow() {

  }

  List<int> getValues(){
    final retVal=<int>[];
    retVal.clear();
    _dices.forEach((element) {
      //here retrieve the value
    });
    return retVal;
  }
  ///Constructor for the class. [diceCount] tells how many dices we want to render in the available space
  Table() {
    _dices.clear();
  }
}
