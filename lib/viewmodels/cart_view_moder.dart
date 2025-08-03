import 'package:flutter/foundation.dart';
import 'package:market_nest/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _cartItems = [];
  bool _isLoading = false;

  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;

  // Total items count
  int get totalItemsCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // Total price calculation
  double get totalPrice {
    return _cartItems.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  // Check if cart is empty
  bool get isCartEmpty => _cartItems.isEmpty;

  // Add product to cart
  void addToCart(Product product) {
    final existingItemIndex = _cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingItemIndex >= 0) {
      // Product already exists, increase quantity
      _cartItems[existingItemIndex].quantity++;
    } else {
      // Add new product
      _cartItems.add(CartItem(product: product, quantity: 1));
    }
    notifyListeners();
  }

  // Remove product from cart completely
  void removeFromCart(int productId) {
    _cartItems.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  // Increase quantity of a product
  void increaseQuantity(int productId) {
    final itemIndex = _cartItems.indexWhere(
      (item) => item.product.id == productId,
    );
    if (itemIndex >= 0) {
      _cartItems[itemIndex].quantity++;
      notifyListeners();
    }
  }

  // Decrease quantity of a product
  void decreaseQuantity(int productId) {
    final itemIndex = _cartItems.indexWhere(
      (item) => item.product.id == productId,
    );
    if (itemIndex >= 0) {
      if (_cartItems[itemIndex].quantity > 1) {
        _cartItems[itemIndex].quantity--;
      } else {
        // If quantity becomes 0, remove the item
        _cartItems.removeAt(itemIndex);
      }
      notifyListeners();
    }
  }

  // Clear all cart items (for checkout)
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  // Get cart item count for a specific product
  int getProductQuantity(int productId) {
    final item = _cartItems.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(
        product: Product(
          id: -1,
          title: '',
          category: '',
          price: 0.0,
          image: '',
          description: '',
        ),
        quantity: 0,
      ),
    );
    return item.product.id == -1 ? 0 : item.quantity;
  }

  // Check if product is in cart
  bool isProductInCart(int productId) {
    return _cartItems.any((item) => item.product.id == productId);
  }

  // Future method for API integration (if needed later)
  Future<void> syncCartWithAPI() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Here you can implement API call to sync cart with server
      // For now, we'll just simulate loading
      await Future.delayed(Duration(seconds: 1));
    } catch (e) {
      if (kDebugMode) {
        print("Error syncing cart: $e");
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
