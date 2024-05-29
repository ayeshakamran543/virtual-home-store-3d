import 'package:flutter/material.dart';
import 'package:fyp_project/ProdutsTile.dart';

class AddtoCartModel extends ChangeNotifier {
  List<Product> _addToCart = [];

  List<Product> get favorites => _addToCart;

  void addToCart(Product product) {
    if (_addToCart.contains(product)) {
      _addToCart.remove(product);
    } else {
      _addToCart.add(product);
    }
    notifyListeners();
  }

  void clearCart() {
    _addToCart.clear();
    notifyListeners();
  }
}
