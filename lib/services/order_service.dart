import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';

class OrderService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //PLACE ORDER
  Future<void> placeOrder(OrderModel order) async {
    final uid = _auth.currentUser!.uid;

    await _firestore
        .collection("orders")
        .doc(uid)
        .collection("userOrders")
        .add(order.toMap());
  }

  // FETCH USER ORDERS
  Stream<List<OrderModel>> getUserOrders() {
    final uid = _auth.currentUser!.uid;

    return _firestore
        .collection("orders")
        .doc(uid)
        .collection("userOrders")
        .orderBy("date", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        return OrderModel(
          id: doc.id,
          totalAmount: data["totalAmount"],
          items: List<Map<String, dynamic>>.from(data["items"]),
          address: Map<String, dynamic>.from(data["address"]),
          status: data["status"] ?? "Pending",
          date: DateTime.parse(data["date"]),
        );
      }).toList();
    });
  }

  // ⭐ CANCEL ORDER
  Future<void> cancelOrder(String orderId) async {
    final uid = _auth.currentUser!.uid;

    await _firestore
        .collection("orders")
        .doc(uid)
        .collection("userOrders")
        .doc(orderId)
        .update({"status": "Cancelled"});
  }
}
