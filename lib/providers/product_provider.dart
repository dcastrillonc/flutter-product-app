import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();
  final List<Product> _products = [];

  bool _isLoading = false;
  final int _limit = 100;
  bool _hasMore = true;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  ProductProvider() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final newProducts = await _service.fetchProducts(limit: _limit);
      if (newProducts.isEmpty) {
        _hasMore = false;
      } else {
        _products.addAll(newProducts);
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
