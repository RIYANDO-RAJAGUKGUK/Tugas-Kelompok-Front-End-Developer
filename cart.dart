import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/groceries_data.dart'; 

class CartProvider with ChangeNotifier {
  final Map<Groceries, int> _items = {};
  List<Groceries> _shoppingCart = [];
  List<Groceries> get shoppingCart => _shoppingCart;
  List<Groceries> _cartItems = [];
  List<Groceries> get cartItems => _cartItems;

  Map<Groceries, int> get items => {..._items};

  int get itemCount => _items.length;

  double get totalPrice {
    double total = 0.0;
    _items.forEach((item, quantity) {
      total += item.price * quantity;
    });
    return total;
  }

  void addItem(Groceries item) {
    if (_items.containsKey(item)) {
      _items[item] = _items[item]! + 1;
    } else {
      _items[item] = 1;
    }
    notifyListeners();
  }

  void removeItem(Groceries item) {
    if (_items.containsKey(item) && _items[item]! > 1) {
      _items[item] = _items[item]! - 1;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }

  void removeProduct(Groceries item) {
    _items.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void checkout() {
    _items.clear();
    notifyListeners();
  }

  void addToCart(Groceries item) {
    _cartItems.add(item);
    notifyListeners();
  }

  double calculateTotal() {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price;
    }
    return total;
  }

}
