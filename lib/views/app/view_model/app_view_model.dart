import 'package:flutter/foundation.dart';

class AppViewModel extends ChangeNotifier {
  final List<String> _pages = ['Home', 'Serviços', 'Configurações'];

  int _currentPageIndex = 0;
  late String _currentPageName;

  int get currentPageIndex => _currentPageIndex;
  String get currentPageName => _currentPageName;

  AppViewModel() {
    _currentPageName = _pages[_currentPageIndex];
  }

  void changePage(int newPage) {
    _currentPageIndex = newPage;
    _currentPageName = _pages[_currentPageIndex];
    notifyListeners();
  }
}
