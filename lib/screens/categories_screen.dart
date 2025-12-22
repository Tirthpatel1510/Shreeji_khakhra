import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'product_details_screen.dart'; 

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: sampleProducts.length,
        itemBuilder: (ctx, i) {
          final p = sampleProducts[i];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsScreen(product: p),
                ),
              );
            },
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12)),
                      child:
                          Image.asset(p.image, fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF7B3F00)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹${p.price.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartProvider>(context,
                                listen: false)
                            .addProduct(p);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Added ${p.name} to cart'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      child: const Text('Add'),
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
