import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/user.dart';

class AppState extends ChangeNotifier {
  List<Product> _favoriteProducts = [];

  User _currentUser = const User(
    name: 'Максим Устич',
    email: 'maksym.ustych@example.com',
    avatarUrl:
        'https://ui-avatars.com/api/?name=Maksym+Ustych&background=EADDFF&color=6750A4&size=300',
  );

  int _cartItemsCount = 0;

  List<Product> get favoriteProducts =>
      List.unmodifiable(_favoriteProducts);

  User get currentUser => _currentUser;

  int get cartItemsCount => _cartItemsCount;

  void updateUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  void toggleFavorite(Product product) {
    final isAlreadyFavorite = _favoriteProducts.any(
      (item) => item.name == product.name,
    );

    if (isAlreadyFavorite) {
      _favoriteProducts = _favoriteProducts
          .where((item) => item.name != product.name)
          .toList();
    } else {
      _favoriteProducts = [
        ..._favoriteProducts,
        product.copyWith(isFavorite: true),
      ];
    }

    notifyListeners();
  }

  void addToCart(Product product) {
    if (product.name.trim().isEmpty || product.price < 0) {
      return;
    }

    _cartItemsCount++;
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favoriteProducts.any(
      (item) => item.name == product.name,
    );
  }
}