import 'package:flutter/material.dart';
import 'package:market_nest/models/product_model.dart';
import 'package:market_nest/utils/colors.dart';
import 'package:market_nest/view/cart_screen.dart';
import 'package:market_nest/viewmodels/cart_view_moder.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: lightbrown,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: blackColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer<CartViewModel>(
            builder: (context, cartProvider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_bag, color: blackColor),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen()),
                      );
                    },
                  ),
                  // Cart count badge
                  if (cartProvider.totalItemsCount > 0)
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '${cartProvider.totalItemsCount}',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(color: lightbrown),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: greyColor,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            // Product Details
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Price Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        "\$${product.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: greenColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Category Chip
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: greenColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      product.category.toUpperCase(),
                      style: TextStyle(
                        color: greenColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  // Rating Section
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: index < 4
                                ? Colors.orange
                                : greyColor.withOpacity(0.3),
                            size: 20,
                          );
                        }),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "4.2 (128 reviews)",
                        style: TextStyle(color: greyColor, fontSize: 14),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Description Section
                  Text(
                    "Product Description",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 12),
                  Text(
                    product.description,
                    style: TextStyle(
                      color: greyColor,
                      height: 1.6,
                      fontSize: 15,
                    ),
                  ),

                  SizedBox(height: 40),

                  // Action Buttons
                  Consumer<CartViewModel>(
                    builder: (context, cartProvider, child) {
                      return Column(
                        children: [
                          // Add to Cart Button
                          ElevatedButton(
                            onPressed: () {
                              cartProvider.addToCart(product);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: lightbrown,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: Size(double.infinity, 55),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                  color: whiteColor,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  "Add to Cart",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 12),

                          // Buy Now Button
                          ElevatedButton(
                            onPressed: () {
                              cartProvider.addToCart(product);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: greenColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              minimumSize: Size(double.infinity, 55),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.flash_on, color: whiteColor),
                                SizedBox(width: 12),
                                Text(
                                  "Buy Now",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
