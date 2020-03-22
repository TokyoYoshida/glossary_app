import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterStore with ChangeNotifier {
  var count = 0;

  void incrementCounter() {
    count++;
    notifyListeners();
  }
}

