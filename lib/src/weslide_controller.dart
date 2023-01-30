// Controller
import 'package:flutter/material.dart';

/// This class used to control animations, using methods like hide or show
class WeSlideController extends ValueNotifier<bool> {
  /// WeSlideController Construction
  // ignore: avoid_positional_boolean_parameters
  WeSlideController({bool initial = false}) : super(initial);

  /// show WeSlide Panel
  void show() => value = true;

  /// hide WeSlide Panel
  void hide() => value = false;

  /// Returns if the WeSlide Panel is opened or not
  bool get isOpened => value;
}

// if this is keeping track of snap positions, then we shouldn't use a
// changeNotifier
class WeSlideSnapPositionController extends ChangeNotifier {
  double _value = 0;
  double _position = 0;
  int _snapPosition = 1;
  /// we either go up v=1 or down v=0
  void setValue(double v){
    _value = v;
    if(_value == 1 && _snapPosition < (snapPositions.length-1)){
      _snapPosition ++;
      // snap up
    }
    if(_value == 0 && _snapPosition >1){
      _snapPosition --;
      // snap down
    }
  }
  /// not sure what setPosition is for?
  void setPosition(double v){
    _position = v;
    notifyListeners();
  }
  double getPosition(){
    return _position;
  }
  WeSlideSnapPositionController({required this.snapPositions}): super();

  onChange(){
    notifyListeners();
  }
  List <SnapPosition> snapPositions;

  // if there are no SnapPositions, then the it will go from 0 to 1
  // for testing there will be 0.3, .7 and 1.0
  // if the allowFullSlide? is enabled how will the controller determine if
  // that is true?
  setSnapPosition(int a){
    _snapPosition = a;
  }
  /// active if the snap is active
  /// height provides the current height of the container
  Set<double> getSnapPosition({bool active = false, required double height}) {

    if(active == false) {
      return {0.0, 0.0};
    }
    if (_snapPosition == 0) {
      return {0.0, 0.0};
    }
    /// if snapPosition (n) >0 then it has to return
    /// n and n+1, snapPosition can not be greater than n-1, so if there are
    /// only two entries, n can only be 1

    return ({(snapPositions[_snapPosition-1].type==0)?
      snapPositions[_snapPosition-1].snapPosition * height:
      snapPositions[_snapPosition-1].snapPosition,
      (snapPositions[_snapPosition].type==0)?
        snapPositions[_snapPosition].snapPosition * height:
      snapPositions[_snapPosition].snapPosition,
    });
  }
  int getValue(){
    return _snapPosition;
  }
}

class SnapPosition {
  SnapPosition({this.type = 0, this.snapPosition = 0});
  /// type is either a ratio or a pixel distance, default is ratio
  int type;
  double snapPosition;
}
