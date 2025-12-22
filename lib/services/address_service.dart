import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/address_model.dart';

class AddressService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ✅ SAFE address collection reference
  CollectionReference<Map<String, dynamic>>? _addressCollection() {
    final user = _auth.currentUser;

    // 🔴 VERY IMPORTANT: user can be null after long time
    if (user == null) {
      return null;
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('addresses');
  }

  // ⭐ Add new address
  Future<void> addAddress(Address address) async {
    final ref = _addressCollection();
    if (ref == null) return;

    await ref.add({
      'fullName': address.fullName,
      'phoneNumber': address.phoneNumber,
      'street': address.street,
      'locality': address.locality,
      'pincode': address.pincode,
      'city': address.city,
      'state': address.state,
      'type': address.type,
    });
  }

  // ⭐ Get all addresses (FIXED – no infinite loading)
  Stream<List<Address>> getAddresses() {
    final ref = _addressCollection();

    // 🔴 If user logged out → return empty stream (NO LOADING)
    if (ref == null) {
      return Stream.value([]);
    }

    return ref.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();

        return Address(
          id: doc.id,
          fullName: data['fullName'] ?? '',
          phoneNumber: data['phoneNumber'] ?? '',
          street: data['street'] ?? '',
          locality: data['locality'] ?? '',
          pincode: data['pincode'] ?? '',
          city: data['city'] ?? '',
          state: data['state'] ?? '',
          type: data['type'] ?? '',
        );
      }).toList();
    });
  }

  // ⭐ Delete address
  Future<void> deleteAddress(String id) async {
    final ref = _addressCollection();
    if (ref == null) return;

    await ref.doc(id).delete();
  }
}
