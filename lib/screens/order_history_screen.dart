import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/order_service.dart';
import '../models/order_model.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6EB),
      appBar: AppBar(
        title: const Text("Order History"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
      ),

      body: StreamBuilder<List<OrderModel>>(
        stream: OrderService().getUserOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No orders found",
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final orders = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final orderDate =
                  DateFormat('dd MMM yyyy • hh:mm a').format(order.date);

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ⭐ ORDER HEADER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order #${order.id.substring(0, 6)}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: order.status == "Cancelled"
                                ? Colors.red.shade100
                                : Colors.green.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            order.status,
                            style: TextStyle(
                              fontSize: 12,
                              color: order.status == "Cancelled"
                                  ? Colors.red
                                  : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Text(
                      orderDate,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ⭐ PRODUCTS SLIDER
                    SizedBox(
                      height: 80,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: order.items.map((item) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                item['image'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ⭐ ADDRESS
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on_outlined, size: 20),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            "${order.address['fullName']}\n"
                            "${order.address['street']}, ${order.address['locality']}\n"
                            "${order.address['city']} - ${order.address['pincode']}",
                            style: const TextStyle(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ⭐ PRICE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Amount",
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          "₹${order.totalAmount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // ⭐ VIEW + CANCEL
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            _showOrderDetails(context, order);
                          },
                          child: const Text("View Details →"),
                        ),

                        if (order.status == "Pending")
                          TextButton(
                            onPressed: () {
                              _confirmCancel(context, order);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ⭐ SHOW ORDER DETAILS BOTTOM SHEET
  void _showOrderDetails(BuildContext context, OrderModel order) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Order Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              ...order.items.map((item) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      item['image'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(item['name']),
                  subtitle: Text(
                    "₹${item['price']} x ${item['quantity']}",
                  ),
                );
              }).toList(),

              const SizedBox(height: 20),

              const Text(
                "Delivery Address:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),
              Text(
                "${order.address['fullName']}\n"
                "${order.address['street']}, ${order.address['locality']}\n"
                "${order.address['city']} - ${order.address['pincode']}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }

  // ⭐ CANCEL ORDER POPUP
  void _confirmCancel(BuildContext context, OrderModel order) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Cancel Order?"),
          content: const Text(
            "Are you sure you want to cancel this order?",
          ),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Yes, Cancel"),
              onPressed: () async {
                await OrderService().cancelOrder(order.id);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
