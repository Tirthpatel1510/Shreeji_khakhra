import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/product.dart';
import '../screens/product_details_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 Use real products for slider (first 4 products)
    final List<Product> sliderProducts = sampleProducts.take(4).toList();

    // 🔥 Use real products for best sellers (you can change indexes)
    final List<Product> bestSellers = [
      sampleProducts[2],
      sampleProducts[3],
      sampleProducts[4],
      sampleProducts[6],
      sampleProducts[7],
      sampleProducts[9],
      sampleProducts[10],
      sampleProducts[11],
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= PRODUCT SLIDER =================
          CarouselSlider(
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
            ),
            items: sliderProducts.map((product) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsScreen(product: product),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          // ================= BEST SELLERS =================
          _buildSectionHeader(context, 'Best Sellers'),
          const SizedBox(height: 12),
          _buildProductGrid(context, bestSellers),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  // ================= BEST SELLER GRID =================
  Widget _buildProductGrid(BuildContext context, List<Product> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final product = products[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsScreen(product: product),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF7B3F00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '₹${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Color(0xFFF77F00),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
