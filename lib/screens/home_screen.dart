import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/providers/product_provider.dart';
import 'package:e_shop/widgets/product_card.dart';
import 'package:e_shop/widgets/category_chip.dart';
import 'package:e_shop/widgets/search_bar.dart';
import 'package:e_shop/providers/cart_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load sample products when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadSampleProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Shop'),
        elevation: 0,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                  if (cart.items.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.items.length}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          IconButton(
            onPressed: () {
              // TODO: Navigate to user profile or settings
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('User profile coming soon!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () async {
              productProvider.loadSampleProducts();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  const CustomSearchBar(),
                  const SizedBox(height: 20),

                  // Categories Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Categories',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            height: 40,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: productProvider.categories.length,
                              itemBuilder: (context, index) {
                                final category =
                                    productProvider.categories[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right:
                                        index <
                                            productProvider.categories.length -
                                                1
                                        ? 12
                                        : 0,
                                  ),
                                  child: CategoryChip(
                                    label: category,
                                    isSelected:
                                        productProvider.selectedCategory ==
                                        category,
                                    onTap: () =>
                                        productProvider.setCategory(category),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // All Products Card
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'All Products',
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${productProvider.filteredProducts.length} items',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Products Grid
                          if (productProvider.filteredProducts.isEmpty)
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No products found',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(color: Colors.grey[600]),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Try adjusting your search or category filter',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.grey[500]),
                                  ),
                                ],
                              ),
                            )
                          else
                            LayoutBuilder(
                              builder: (context, constraints) {
                                // Responsive grid based on screen width
                                int crossAxisCount =
                                    2; // Default for mobile (2 products per row)
                                double childAspectRatio =
                                    0.75; // Adjusted to prevent overflow

                                if (constraints.maxWidth > 600) {
                                  crossAxisCount = 3; // Tablet
                                  childAspectRatio = 0.7;
                                }
                                if (constraints.maxWidth > 900) {
                                  crossAxisCount = 4; // Desktop
                                  childAspectRatio = 0.75;
                                }
                                if (constraints.maxWidth > 1200) {
                                  crossAxisCount = 5; // Large desktop
                                  childAspectRatio = 0.8;
                                }

                                return GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        childAspectRatio: childAspectRatio,
                                        crossAxisSpacing: 8, // Reduced spacing
                                        mainAxisSpacing: 8, // Reduced spacing
                                      ),
                                  itemCount:
                                      productProvider.filteredProducts.length,
                                  itemBuilder: (context, index) {
                                    final product =
                                        productProvider.filteredProducts[index];
                                    return ProductCard(product: product);
                                  },
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
