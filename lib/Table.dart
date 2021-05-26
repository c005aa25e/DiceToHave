import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'positionedWidget.dart';

class Table {
  List<PositionedWidget> _dice=[];
  int _count;
  bool _rotationEnabled;
  bool _randomPosition;

  List<Widget> _getPositionedWidgetList(BuildContext context,BoxConstraints constraints){
    List<Widget> retVal=[];
    _dice.forEach((element) {
      retVal.add(Positioned(
        left: element.left,
        top: element.top,
        height: element.height,
        width: element.width,
        child: element.getDieWidget(context)
      ));
    });
    return retVal;
  }

  void _calculatePositions(BoxConstraints constraints){
    double availableHeight=constraints.maxHeight;
    double availableWidth=constraints.maxWidth;
    int rowCount=1;
    int colCount=1;

    while (rowCount*colCount<_count) {
      if (availableHeight/rowCount>availableWidth/colCount){
        rowCount++;
      } else {
        colCount++;
      }
    }

    for (int i = 0; i < _dice.length; i++) {
      int row=i~/colCount;
      int col=i%colCount;
      double cellHeight=availableHeight/rowCount;
      double cellWidth=availableWidth/colCount;
      _dice[i].left=col*cellWidth.toDouble();
      _dice[i].top=row*cellHeight.toDouble();
      _dice[i].width=cellWidth;
      _dice[i].height=cellHeight;
    }
  }

  ///returns the Widget code to display. [context] informs the calculations about the available space.
  Widget getWidget(BuildContext context,{diceCount=1}) {
    return LayoutBuilder(
        builder: (context, constraints){
        _calculatePositions(constraints);
        return Stack(
            children: _getPositionedWidgetList(context,constraints)
       );
      }
    );
  }

  void doRoll() {
    _dice.forEach((element) {
      element.doRoll();
    });
  }

  ///Populating the dice list with dice
  void _populateDiceList(){
    _dice.clear();
    for (int i=0;i<_count;i++){
      _dice.add(PositionedWidget());
    }
    _updateDiceAlignment();
  }

  int getSumOfValues(){
    int retVal=0;
    _dice.forEach((element) {
      retVal+=element.value;
    });
    return retVal;
  }

  List<int> getValues(){
    final retVal=<int>[];
    retVal.clear();
    _dice.forEach((element) {
      retVal.add(element.value);
    });
    return retVal;
  }
  ///Constructor for the class. [diceCount] tells how many dices we want to render in the available space
  Table({int diceCount = 1, bool rotationEnabled=true, bool randomPosition=false}) {
    this.count=diceCount;
    this.rotationEnabled=rotationEnabled;
    this.rotationEnabled=randomPosition;
    _populateDiceList();
  }

  void _updateDiceAlignment(){
    _dice.forEach((element) {
      element.rotation=_rotationEnabled;
      element.randomPosition=_randomPosition;
    });
  }

  bool get randomPosition => _randomPosition;

  set randomPosition(bool value) {
    _randomPosition = value;
    _updateDiceAlignment();
  }

  bool get rotationEnabled => _rotationEnabled;

  set rotationEnabled(bool value) {
    _rotationEnabled = value;
    _updateDiceAlignment();
  }

  int get count => _count;

  set count(int value) {
    _count = (value<1?1:value);
    _populateDiceList();
  }

}
