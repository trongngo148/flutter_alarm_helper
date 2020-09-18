import 'package:flutter/cupertino.dart';

class MyThemeModel extends ChangeNotifier {
  bool _isListenTheme = true;
  bool _isCollapsed = true;
  void changeTheme() {
    _isListenTheme = !_isListenTheme;
    notifyListeners();
  }

  void changeColl() {
    _isCollapsed = !_isCollapsed;
    notifyListeners();
  }

  bool get isCollapsed => _isCollapsed;
  bool get isListenTheme => _isListenTheme;
}
