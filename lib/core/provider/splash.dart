import 'package:flutter/cupertino.dart';

class SplashProvider extends ChangeNotifier {
  String mainCurrency = '';
  void setCurrency(String newMain) {
    mainCurrency = newMain;
    notifyListeners();
  }
}
