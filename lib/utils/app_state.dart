import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/user.dart';

class AppState extends ChangeNotifier {
  User currentUser = const User(
    name: 'Максим Устич',
    email: 'maksym.ustych@example.com',
    avatarUrl: 'https://i.pravatar.cc/300',
  );

  final List<Product> favoriteProducts = [];

  int cartItemsCount = 0;

  void toggleFavorite(Product product) {
    final index = favoriteProducts.indexWhere(
      (item) => item.name == product.name,
    );

    if (index >= 0) {
      favoriteProducts.removeAt(index);
    } else {
      favoriteProducts.add(
        product.copyWith(isFavorite: true),
      );
    }

    notifyListeners();
  }

  void addToCart() {
    cartItemsCount++;
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return favoriteProducts.any(
      (item) => item.name == product.name,
    );
  }
}