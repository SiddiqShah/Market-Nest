class CartProduct {
  final int productId;
  final int quantity;

  CartProduct({required this.productId, required this.quantity});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}

class CartModel {
  final int id;
  final int userId;
  final List<CartProduct> products;

  CartModel({required this.id, required this.userId, required this.products});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      products: (json['products'] as List)
          .map((e) => CartProduct.fromJson(e))
          .toList(),
    );
  }
}
