import 'package:flutter/material.dart';
import 'course.dart';

class CartProvider extends ChangeNotifier {
  final List<Course> _cartItems = [];

  List<Course> get cartItems => List.unmodifiable(_cartItems);

  void addToCart(Course course) {
    if (!_cartItems.contains(course)) {
      _cartItems.add(course);
      notifyListeners();
    }
  }

  void removeFromCart(Course course) {
    _cartItems.remove(course);
    notifyListeners();
  }

  bool isInCart(Course course) => _cartItems.contains(course);

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
} 