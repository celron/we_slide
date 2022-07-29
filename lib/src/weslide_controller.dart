// Controller
import 'package:flutter/material.dart';

/// This class used to control animations, using methods like hide or show
class WeSlideController extends ValueNotifier<bool> {
  /// WeslideController Construction
  WeSlideController() : super(false);

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
  void setValue(double v){
    _value = v;
    if(_value == 1 && _snapPosition <2){
      _snapPosition ++;
      // snap up
    }
    if(_value == 0 && _snapPosition >1){
      _snapPosition --;
      // snap down
    }
  }
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
  Set<double> getSnapPosition({bool active = false}) {

    if(active == false) {
      return {0.0, 0.0};
    }
    if (_snapPosition == 0) {
      return {0.0, 0.0};
    }
    // if it is at position 1 then it is at 0.7
    // it can go down to 0.3 or up to 1.0
    if (_snapPosition == 1) {
      return {0.3, .7};
    }
    if (_snapPosition ==2){
      return {.7, 1.0};
    }
    return {0.0, 0.0};
  }
}

class SnapPosition {
  SnapPosition({this.type = 0, this.snapPosition = 0});
  /// type is either a ratio or a pixel distance, default is ratio
  int type;
  double snapPosition;
}
