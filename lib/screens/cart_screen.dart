import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/address_model.dart';
import '../services/address_service.dart';
import '../services/order_service.dart';
import '../models/order_model.dart';
import 'order_success_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Address? selectedAddress;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items.values.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF6EB),
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= ADDRESS SECTION =================
                  const Text(
                    "Select Delivery Address",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: StreamBuilder<List<Address>>(
                      stream: AddressService().getAddresses(),
                      builder: (context, snapshot) {
                        // 🔴 FIX 1: Handle loading properly
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        // 🔴 FIX 2: Handle error
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text("Failed to load addresses"));
                        }

                        // 🔴 FIX 3: Handle empty
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text("No address found"));
                        }

                        final addresses = snapshot.data!;

                        return ListView(
                          padding: const EdgeInsets.all(8),
                          children: addresses.map((a) {
                            return RadioListTile<Address>(
                              value: a,
                              groupValue: selectedAddress,
                              activeColor: Colors.orange,
                              title: Text(
                                a.fullName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "${a.street}, ${a.locality}, ${a.city} - ${a.pincode}",
                              ),
                              onChanged: (value) {
                                setState(() {
                                  selectedAddress = value;
                                });
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= CART ITEMS =================
                  const Text(
                    "Your Items",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  if (items.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Your cart is empty"),
                      ),
                    )
                  else
                    Column(
                      children: items.map((it) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12.withOpacity(0.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                it.product.image,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              it.product.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("₹${it.product.price}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () =>
                                      cart.changeQuantity(it.product.id, -1),
                                ),
                                Text("${it.quantity}"),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () =>
                                      cart.changeQuantity(it.product.id, 1),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ),

          // ================= CHECKOUT BAR =================
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: ₹${cart.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (items.isEmpty) return;

                      if (selectedAddress == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please select a delivery address"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      final orderItems = cart.items.values.map((i) {
                        return {
                          "productId": i.product.id,
                          "name": i.product.name,
                          "price": i.product.price,
                          "image": i.product.image,
                          "quantity": i.quantity,
                        };
                      }).toList();

                      final order = OrderModel(
                        id: "",
                        totalAmount: cart.totalPrice,
                        items: List<Map<String, dynamic>>.from(orderItems),
                        address: selectedAddress!.toMap(),
                        date: DateTime.now(),
                      );

                      await OrderService().placeOrder(order);
                      cart.clearCart();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const OrderSuccessScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Place Order",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
