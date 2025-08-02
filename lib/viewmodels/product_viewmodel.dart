import 'package:flutter/material.dart';
import 'package:market_nest/models/product_model.dart';
import 'package:market_nest/services/product_api_service.dart';

class ProductViewModel extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = true;
  String _selectedCategory = 'All';

  List<String> categories = [
    'All',
    "men's clothing",
    'jewelery',
    'electronics',
    "women's clothing",
  ];

  String _searchProduct = '';

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;

  /// ✅ Combined filter: category + search
  List<Product> get filteredProducts {
    List<Product> categoryFiltered = _selectedCategory == 'All'
        ? _products
        : _products
              .where(
                (product) =>
                    product.category.toLowerCase() ==
                    _selectedCategory.toLowerCase(),
              )
              .toList();

    if (_searchProduct.isEmpty) return categoryFiltered;

    return categoryFiltered
        .where(
          (product) => product.title.toLowerCase().contains(
            _searchProduct.toLowerCase(),
          ),
        )
        .toList();
  }

  /// ✅ Fetch all products
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await ProductApiService.getProducts();
    } catch (e) {
      print("Error fetching products: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  /// ✅ Category select
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  /// ✅ Search update
  void updateSearchProduct(String query) {
    _searchProduct = query;
    notifyListeners();
  }
}
