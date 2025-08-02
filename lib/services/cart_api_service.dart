import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_model.dart';

class CartService {
  static Future<CartModel> fetchCart(int userId) async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/carts/user/$userId'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> cartList = json.decode(response.body);
      return CartModel.fromJson(cartList.last); // Get most recent cart
    } else {
      throw Exception('Failed to load cart');
    }
  }
}
