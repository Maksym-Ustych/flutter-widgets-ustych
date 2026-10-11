import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/app_state.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  final AppState appState;

  const ProductsScreen({
    super.key,
    required this.appState,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Product> products = const [
    Product(
      name: 'Ноутбук',
      description: 'Потужний ноутбук для навчання та роботи.',
      price: 29999,
      originalPrice: 32999,
      imageUrl: 'https://picsum.photos/600/400?random=1',
    ),
    Product(
      name: 'Смартфон',
      description: 'Сучасний смартфон з хорошою камерою.',
      price: 15999,
      originalPrice: 17999,
      imageUrl: 'https://picsum.photos/600/400?random=2',
    ),
    Product(
      name: 'Навушники',
      description: 'Бездротові навушники для музики та дзвінків.',
      price: 2499,
      imageUrl: 'https://picsum.photos/600/400?random=3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Товари'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          final updatedProduct = product.copyWith(
            isFavorite: widget.appState.isFavorite(product),
          );

          return ProductCard(
            product: updatedProduct,
            onFavoriteToggle: () {
              setState(() {
                widget.appState.toggleFavorite(product);
              });
            },
            onAddToCart: () {
              widget.appState.addToCart();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${product.name} додано в кошик',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}