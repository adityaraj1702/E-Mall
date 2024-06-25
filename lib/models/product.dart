class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final bool isFeatured;
  final String category;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.isFeatured = false,
    required this.category,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'isFeatured': isFeatured,
      'category': category,
      'images': images,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      isFeatured: map['isFeatured'],
      category: map['category'],
      images: List<String>.from(map['images']),
    );
  }
}
