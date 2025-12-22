import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final results = sampleProducts.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              query = value;
            });
          },
        ),
      ),
      body: query.isEmpty
          ? const Center(
              child: Text(
                'Search for products',
                style: TextStyle(fontSize: 16),
              ),
            )
          : results.isEmpty
              ? const Center(
                  child: Text(
                    'No products found',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final product = results[index];
                    return ListTile(
                      leading: Image.asset(
                        product.image,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.name),
                      subtitle: Text(
                          '₹${product.price.toStringAsFixed(2)}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailsScreen(product: product),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
