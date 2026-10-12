import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    this.onFavoriteToggle,
    this.onAddToCart,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isPressed = false;
  bool _isImageZoomed = false;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      onHorizontalDragEnd: (_) {
        widget.onFavoriteToggle?.call();
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Card(
          margin: const EdgeInsets.all(12),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isImageZoomed = !_isImageZoomed;
                      });
                    },
                    child: AnimatedScale(
                      scale: _isImageZoomed ? 1.08 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: Image.network(
                        product.imageUrl,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (
                          context,
                          child,
                          loadingProgress,
                        ) {
                          if (loadingProgress == null) {
                            return child;
                          }

                          return const ShimmerPlaceholder(
                            height: 180,
                          );
                        },
                        errorBuilder: (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return Container(
                            height: 180,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: widget.onFavoriteToggle,
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: product.isFavorite
                            ? Colors.red
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          '${product.price.toStringAsFixed(2)} грн',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (product.originalPrice != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            '${product.originalPrice!.toStringAsFixed(2)} грн',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  decoration:
                                      TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: widget.onAddToCart,
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text('Додати в кошик'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShimmerPlaceholder extends StatefulWidget {
  final double height;

  const ShimmerPlaceholder({
    super.key,
    required this.height,
  });

  @override
  State<ShimmerPlaceholder> createState() =>
      _ShimmerPlaceholderState();
}

class _ShimmerPlaceholderState extends State<ShimmerPlaceholder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseColor =
        Theme.of(context).colorScheme.surfaceContainerHighest;

    final highlightColor =
        Theme.of(context).colorScheme.surfaceContainerLow;

    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final shimmerWidth = constraints.maxWidth * 0.35;

          return ClipRect(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    color: baseColor,
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    final position =
                        (constraints.maxWidth + shimmerWidth) *
                                _controller.value -
                            shimmerWidth;

                    return Transform.translate(
                      offset: Offset(position, 0),
                      child: Container(
                        width: shimmerWidth,
                        height: widget.height,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              highlightColor,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}