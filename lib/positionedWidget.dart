import 'die.dart';

/// Class representing a die rendered in its available space
class PositionedWidget extends Die {
  double left;
  double top;
  double width;
  double height;

  ///Constructor
  PositionedWidget({double left=0, double top=0, double width=0, double height=0}){
    this.left=left;
    this.top=top;
    this.width=width;
    this.height=height;
  }

}
