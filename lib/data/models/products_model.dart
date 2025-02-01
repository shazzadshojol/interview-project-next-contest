class Product {
  final String name;
  final String description;
  final String weight;
  final double price;
  final double originalPrice;
  final bool isPopular;
  final String imageUrl;
  final String categoryId;
  final bool isShowVariant;

  Product({
    required this.name,
    required this.description,
    required this.weight,
    required this.price,
    required this.originalPrice,
    this.isPopular = false,
    required this.imageUrl,
    required this.categoryId,
    this.isShowVariant = false,
  });
}

class Category {
  final String id;
  final String name;
  final String emoji;
  final List<Product> products;

  Category({
    required this.id,
    required this.name,
    required this.emoji,
    required this.products,
  });
}
