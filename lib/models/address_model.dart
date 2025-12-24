import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String street;
  final String locality;
  final String pincode;
  final String city;
  final String state;
  final String type;

  Address({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.street,
    required this.locality,
    required this.pincode,
    required this.city,
    required this.state,
    required this.type,
  });

  //Required for saving in order
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "fullName": fullName,
      "phoneNumber": phoneNumber,
      "street": street,
      "locality": locality,
      "pincode": pincode,
      "city": city,
      "state": state,
      "type": type,
    };
  }

  //Required for reading from Firestore
  factory Address.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Address(
      id: doc.id,
      fullName: data["fullName"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      street: data["street"] ?? "",
      locality: data["locality"] ?? "",
      pincode: data["pincode"] ?? "",
      city: data["city"] ?? "",
      state: data["state"] ?? "",
      type: data["type"] ?? "Other",
    );
  }

  // FIX RADIO BUTTON NOT SELECTING
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Address && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
