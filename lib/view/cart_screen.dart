import 'package:flutter/material.dart';
import 'package:market_nest/utils/colors.dart';
import 'package:market_nest/view/home_screen.dart';
import 'package:market_nest/viewmodels/cart_view_moder.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text("Cart", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: greenColor,
        foregroundColor: whiteColor,
      ),
      body: Consumer<CartViewModel>(
        builder: (context, cartProvider, child) {
          if (cartProvider.isCartEmpty) {
            return _buildEmptyCart(context);
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: cartProvider.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartProvider.cartItems[index];
                    return _buildCartItemCard(context, cartItem, cartProvider);
                  },
                ),
              ),
              _buildCartSummary(context, cartProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 100, color: greyColor),
          SizedBox(height: 20),
          Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: greyColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Add some products to get started",
            style: TextStyle(fontSize: 16, color: greyColor),
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: greenColor,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Start Shopping",
              style: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(
    BuildContext context,
    CartItem cartItem,
    CartViewModel cartProvider,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    cartItem.product.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.image, color: greyColor),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8),
                      Text(
                        cartItem.product.category,
                        style: TextStyle(color: greyColor, fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "\$${cartItem.product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: greenColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),

                // Remove Button
                IconButton(
                  onPressed: () {
                    cartProvider.removeFromCart(cartItem.product.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Product removed from cart"),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),

            SizedBox(height: 16),
            Divider(color: greyColor.withOpacity(0.3)),
            SizedBox(height: 8),

            // Quantity Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quantity:",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Row(
                  children: [
                    // Decrease Button
                    GestureDetector(
                      onTap: () {
                        cartProvider.decreaseQuantity(cartItem.product.id);
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.remove, color: whiteColor, size: 18),
                      ),
                    ),

                    SizedBox(width: 16),

                    // Quantity Display
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: greyColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${cartItem.quantity}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    SizedBox(width: 16),

                    // Increase Button
                    GestureDetector(
                      onTap: () {
                        cartProvider.increaseQuantity(cartItem.product.id);
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.add, color: whiteColor, size: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context, CartViewModel cartProvider) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border(top: BorderSide(color: greyColor)),
        boxShadow: [
          BoxShadow(
            color: greyColor,
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Items Count
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Items:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${cartProvider.totalItemsCount} items",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(height: 12),

          // Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Subtotal:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "\$${cartProvider.totalPrice.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Shipping
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "Free",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: greenColor,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),
          Divider(thickness: 2, color: greyColor),
          SizedBox(height: 16),

          // Total Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOTAL:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${cartProvider.totalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: greenColor,
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Checkout Button
          ElevatedButton(
            onPressed: () {
              _showCheckoutDialog(context, cartProvider);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: greenColor,
              minimumSize: Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Proceed to Checkout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context, CartViewModel cartProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Confirm Order",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Are you sure you want to place this order?"),
              SizedBox(height: 16),
              Text(
                "Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: greenColor,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                cartProvider.clearCart();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("🎉 Order placed successfully!"),
                    backgroundColor: greenColor,
                    duration: Duration(seconds: 2),
                  ),
                );

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: greenColor),
              child: Text("Place Order", style: TextStyle(color: whiteColor)),
            ),
          ],
        );
      },
    );
  }
}
