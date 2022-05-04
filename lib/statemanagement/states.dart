import 'dart:async';

import 'package:flutter/material.dart';
import 'package:eddy_support_app/widgets/airlinegrid.dart';

class SideMenuStateManager with ChangeNotifier {
  bool _transitionAnimation = false;
  int _currIndex = 0;

  bool get transitionAnimation => _transitionAnimation;
  int get currIndex => _currIndex;

  void swapTransitionStates() {
    transitionAnimation = _transitionAnimation ? false : true;
  }
  set transitionAnimation(bool newValue) {
    _transitionAnimation = newValue;
    notifyListeners();
  }

  set currIndex(int newValue) {
    _currIndex = newValue;
    notifyListeners();
  }
}



/// Side menu extended mode toggler.
class ExtendMenuStateManager with ChangeNotifier {
  bool _isRailOpen = false;
  bool get isRailOpen => _isRailOpen;

  void swapRailExtent() {
    isRailOpen = _isRailOpen ? false : true;
  }
  set isRailOpen(bool newValue) {
    _isRailOpen = newValue;
    notifyListeners();
  }
}

/// Controls the Control Panel's Search Box's state.
class CPTextBoxState with ChangeNotifier{
  final TextEditingController textController = TextEditingController();
  Timer? timer;
  
  void notify(){
    if (timer != null) {
      timer?.cancel();
    }
    timer = Timer(const Duration(milliseconds: 250), () => notifyListeners());
  }

  void openAirlinePage(){
    
  }
}