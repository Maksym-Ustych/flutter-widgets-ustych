class Product {
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final bool isFavorite;

  const Product({
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Product copyWith({
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Product(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}