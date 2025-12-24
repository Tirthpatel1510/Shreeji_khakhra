import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/order_model.dart';

class OrderService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //PLACE ORDER
  Future<void> placeOrder(OrderModel order) async {
    final user = _auth.currentUser;
    if (user == null) {
      // Not logged in; surface a clear error to the caller
      throw FirebaseException(
        plugin: 'orders',
        message: 'User not authenticated. Please log in to place orders.',
      );
    }

    final map = order.toMap();
    // Ensure Firestore stores a sortable server timestamp
    map['date'] = FieldValue.serverTimestamp();

    await _firestore
        .collection("orders")
        .doc(user.uid)
        .collection("userOrders")
        .add(map);
  }

  // FETCH USER ORDERS
  Stream<List<OrderModel>> getUserOrders() {
    final user = _auth.currentUser;
    if (user == null) {
      // Return an empty stream if not logged in
      return const Stream<List<OrderModel>>.empty();
    }

    return _firestore
        .collection("orders")
        .doc(user.uid)
        .collection("userOrders")
        .orderBy("date", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        final rawDate = data["date"];
        DateTime parsedDate;
        if (rawDate is Timestamp) {
          parsedDate = rawDate.toDate();
        } else if (rawDate is String) {
          parsedDate = DateTime.tryParse(rawDate) ?? DateTime.now();
        } else {
          parsedDate = DateTime.now();
        }

        return OrderModel(
          id: doc.id,
          totalAmount: (data["totalAmount"] as num).toDouble(),
          items: List<Map<String, dynamic>>.from(data["items"]),
          address: Map<String, dynamic>.from(data["address"]),
          status: data["status"] ?? "Pending",
          date: parsedDate,
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
