class OrderModel {
  final String id;
  final double totalAmount;
  final List<Map<String, dynamic>> items;
  final Map<String, dynamic> address;
  final String status;
  final DateTime date;

  OrderModel({
    required this.id,
    required this.totalAmount,
    required this.items,
    required this.address,
    this.status = "Pending",
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      "totalAmount": totalAmount,
      "items": items,
      "address": address,
      "status": status,
      "date": date.toIso8601String(),
    };
  }
}
