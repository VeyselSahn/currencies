import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nekadarparamvar/core/service/api.dart';

class DataProvider extends ChangeNotifier {
  DateFormat df = DateFormat('yyyy-MM-dd');
  DateFormat hm = DateFormat('jm');
  Map<String, dynamic> yesterdayResults = {};
  Map<String, dynamic> todayResults = {};
  Map<String, dynamic> searchResult = {};

  dynamic fetchTime;

  Future<void> prepareData() async {
    change();
    await Api().getData().then((value) => fillLists(value));
    change();
  }

  var loading = false;
  void searchClear() {
    searchResult.clear();
    notifyListeners();
  }

  void change() {
    loading = !loading;
    notifyListeners();
  }

  bool isSearchOpen = false;
  void search(bool newStatus) {
    isSearchOpen = newStatus;
    notifyListeners();
  }

  String getDate(int day) {
    return df.format(DateTime.now().subtract(Duration(days: day)));
  }

  void fillLists(Response response) {
    fetchTime = hm.format(DateTime.fromMillisecondsSinceEpoch(
        response.data['query']['timestamp'] * 1000));
    if (response.data['data'][getDate(0)] != null) {
      yesterdayResults = response.data['data'][getDate(1)] ?? {};
      todayResults = response.data['data'][getDate(0)] ?? {};
    } else {
      yesterdayResults = response.data['data'][getDate(2)] ?? {};
      todayResults = response.data['data'][getDate(1)] ?? {};
    }
    notifyListeners();
  }

  void fillSearch(String code) {
    var all = todayResults.entries;
    for (var i = 0; i < all.length; i++) {
      if (all.elementAt(i).key.contains(code.toUpperCase())) {
        searchResult[all.elementAt(i).key] = all.elementAt(i).value;
      }
    }
    notifyListeners();
  }
}
