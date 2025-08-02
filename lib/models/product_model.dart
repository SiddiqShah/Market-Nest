class Product {
  final int id;
  final String title;
  final String category;
  final double price;
  final String image;
  final String description; // ✅ Add this

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.image,
    required this.description, // ✅ Constructor updated
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      category: json['category'] ?? 'Unknown',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['image'] ?? '',
      description: json['description'] ?? 'No description available', // ✅
    );
  }
}
