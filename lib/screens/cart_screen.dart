import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items.values.toList();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (ctx, i) {
                      final it = items[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: Image.asset(it.product.image, width: 60, fit: BoxFit.cover),
                          title: Text(it.product.name),
                          subtitle: Text('₹${it.product.price} x ${it.quantity}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: () => cart.changeQuantity(it.product.id, -1), icon: const Icon(Icons.remove)),
                              Text('${it.quantity}'),
                              IconButton(onPressed: () => cart.changeQuantity(it.product.id, 1), icon: const Icon(Icons.add)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: ₹${cart.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: items.isEmpty ? null : () {
                    // placeholder checkout action
                    showDialog(context: context, builder: (_) => AlertDialog(
                      title: const Text('Checkout'),
                      content: Text('Proceed to checkout (total ₹${cart.totalPrice.toStringAsFixed(2)})'),
                      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
                    ));
                  },
                  child: const Text('Checkout'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
