import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount =>
      _items.length == 0 ? 0 : _items.values.fold(0, (t, e) => t + e.quantity);

  double get totalPrice =>
      _items.values.fold(0.0, (t, e) => t + e.product.price * e.quantity);

  void addProduct(Product p) {
    if (_items.containsKey(p.id)) {
      _items[p.id]!.quantity += 1;
    } else {
      _items[p.id] = CartItem(product: p, quantity: 1);
    }
    notifyListeners();
  }

  void removeProduct(String productId) {
    if (!_items.containsKey(productId)) return;
    _items.remove(productId);
    notifyListeners();
  }

  void changeQuantity(String productId, int delta) {
    if (!_items.containsKey(productId)) return;
    _items[productId]!.quantity += delta;
    if (_items[productId]!.quantity <= 0) _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
