import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  // Best sellers product data
  static const List<Map<String, String>> bestSellersProducts = [
    {'image': 'lib/assets/images/Jerra Khkhra.webp', 'name': 'Jerra Khakhra'},
    {'image': 'lib/assets/images/Kothmir Marcha.jpg', 'name': 'Kothmir Marcha'},
    {
      'image': 'lib/assets/images/Manchurain Khakhra.jpg',
      'name': 'Manchurain Khakhra'
    },
    {'image': 'lib/assets/images/masla khakhra.webp', 'name': 'Masla Khakhra'},
    {'image': 'lib/assets/images/Methi Khakhra.webp', 'name': 'Methi Khakhra'},
    {
      'image': 'lib/assets/images/Peri Peri Khakhra.jpg',
      'name': 'Peri Peri Khakhra'
    },
    {'image': 'lib/assets/images/Pizza Khakhra.jpg', 'name': 'Pizza Khakhra'},
    {'image': 'lib/assets/images/Plain khakhra.jpg', 'name': 'Plain Khakhra'},
  ];

  @override
  Widget build(BuildContext context) {
    // Slider images - using product images
    final List<String> promoImages = [
      'lib/assets/images/Jerra Khkhra.webp',
      'lib/assets/images/Peri Peri Khakhra.jpg',
      'lib/assets/images/Pizza Khakhra.jpg',
      'lib/assets/images/Manchurain Khakhra.jpg',
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Promotional Banner
          CarouselSlider(
            options: CarouselOptions(
              height: 250.0,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.9,
            ),
            items: promoImages.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      color: const Color(0xFFFFF8EC),
                      child: Image.asset(
                        i,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          const SizedBox(height: 24),

          // Best Sellers Section (2x4 grid)
          _buildSectionHeader(context, 'Best Sellers'),
          const SizedBox(height: 12),
          _buildProductGrid(context),
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

  Widget _buildProductGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: bestSellersProducts.map((product) {
          return Card(
            color: Theme.of(context).colorScheme.surface,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(product['image']!, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product['name']!,
                          style: TextStyle(
                              color: const Color(0xFF7B3F00),
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text('₹99.00',
                          style: TextStyle(color: const Color(0xFFF77F00))),
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
