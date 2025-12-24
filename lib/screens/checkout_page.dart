import 'package:flutter/material.dart';
import '../services/razorpay_service.dart';

class CheckoutPage extends StatelessWidget {
  final RazorpayService razorpayService = RazorpayService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            razorpayService.openCheckout(299); // ₹299
          },
          child: Text("Pay Now"),
        ),
      ),
    );
  }
}
