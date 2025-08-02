import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:market_nest/models/product_model.dart';

class ProductApiService {
  static Future<List<Product>> getProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
