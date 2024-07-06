import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/groceries_data.dart';

class ProfileProvider with ChangeNotifier {
  String _name = '';
  String _email = '';
  String _phone = '';
  DateTime _dob = DateTime(1990, 1, 1);

  Set<Groceries> _savedItems = {};
  List<OrderHistory> _orderHistoryList = [];

  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get dob => '${_dob.day}/${_dob.month}/${_dob.year}';
  Set<Groceries> get savedItems => _savedItems;
  List<OrderHistory> get orderHistoryList => _orderHistoryList;

  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

  void updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void updatePhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void updateDob(DateTime dob) {
    _dob = dob;
    notifyListeners();
  }

  void addOrderToHistory(Groceries product) {
    OrderHistory newOrder = OrderHistory(
      product: product,
      orderDate: DateTime.now(),
    );
    _orderHistoryList.add(newOrder);
    notifyListeners();
  }

  void toggleSaved(Groceries product) {
    if (_savedItems.contains(product)) {
      _savedItems.remove(product);
    } else {
      _savedItems.add(product);
    }
    notifyListeners();
  }

  void removeFromFavorites(Groceries product) {
    if (_savedItems.contains(product)) {
      _savedItems.remove(product);
      notifyListeners();
    }
  }
}
