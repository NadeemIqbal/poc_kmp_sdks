/// Dart representation of the Product data class from the shared SDK
class Product {
  final String id;
  final String title;
  final String description;
  final double price;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
  });

  /// Creates a Product from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  /// Converts the Product to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
    };
  }

  /// Creates a copy of this Product with optional parameter overrides
  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price;
  }

  @override
  int get hashCode => Object.hash(id, title, description, price);

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, price: $price)';
  }
}
