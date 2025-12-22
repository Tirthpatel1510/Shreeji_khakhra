import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'product_details_screen.dart'; // ⭐ NEW

class ProductListScreen extends StatelessWidget {
  final Category category;
  const ProductListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final products =
        sampleProducts.where((p) => p.categoryId == category.id).toList();

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          final p = products[i];

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
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ListTile(
                leading:
                    Image.asset(p.image, width: 60, fit: BoxFit.cover),
                title: Text(p.name),
                subtitle: Text(
                  '₹${p.price.toStringAsFixed(2)}',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addProduct(p);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added ${p.name} to cart'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text('Add'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
