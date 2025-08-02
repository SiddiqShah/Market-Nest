import 'package:flutter/material.dart';
import 'package:market_nest/utils/colors.dart';
import 'package:market_nest/view/product_detail_screen.dart';
import 'package:market_nest/viewmodels/product_viewmodel.dart';
import 'package:market_nest/widgets/bottom_nav_bar.dart';
import 'package:market_nest/widgets/catagort_filter_button.dart';
import 'package:market_nest/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductViewModel>(context, listen: false).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductViewModel>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              ListTile(
                title: const Text(
                  'Hi Siddiq!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                subtitle: const Text(
                  'Good Morning',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                trailing: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/1.jpg'),
                ),
              ),
              const SizedBox(height: 16),
              const SearchBarWidget(),
              const SizedBox(height: 17),

              // Category Filters
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: productProvider.categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final category = productProvider.categories[index];
                    return CategoryFilterButton(
                      text: category,
                      isSelected: productProvider.selectedCategory == category,
                      onTap: () {
                        productProvider.setCategory(category);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 17),

              // Product List or Loading or Not Found
              productProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : productProvider.filteredProducts.isEmpty
                  ? Builder(
                      builder: (context) {
                        Future.microtask(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('⚠️ No products found.'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        });

                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Text(
                              'No products found.',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: greyColor,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(right: 20),
                          itemCount: productProvider.filteredProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.65,
                              ),
                          itemBuilder: (context, index) {
                            final product =
                                productProvider.filteredProducts[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductDetailScreen(product: product),
                                  ),
                                );
                              },
                              child: ItemContainer(
                                img: product.image,
                                title: product.title,
                                price: '\$${product.price.toStringAsFixed(2)}',
                              ),
                            );
                          },
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class ItemContainer extends StatelessWidget {
  final String img, title, price;

  const ItemContainer({
    super.key,
    required this.img,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Container(
            height: 184,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(img),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        const SizedBox(height: 4),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(price, style: TextStyle(color: Colors.grey[700])),
        ),
      ],
    );
  }
}
