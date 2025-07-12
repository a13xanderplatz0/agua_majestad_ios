import 'package:flutter/material.dart';
import '../models/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<ProductModel> _items = [];

  List<ProductModel> get items => List.unmodifiable(_items);

  int get count => _items.fold(0, (sum, item) => sum + item.quantity);

  int get totalItems => _items.fold(0, (sum, item) => sum + item.quantity);

  double get total => _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  void add(ProductModel product) {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _items[index].quantity += product.quantity;
    } else {
      _items.add(product);
    }
    notifyListeners();
  }

  void remove(ProductModel product) {
    _items.removeWhere((item) => item.id == product.id);
    notifyListeners();
  }

  void increaseQuantity(ProductModel product) {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decreaseQuantity(ProductModel product) {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
} 