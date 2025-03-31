import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

//Provider responsable de gestionar el estado de la lista de productos
//Utiliza ChangeNotifier para notificar a los widgets cuando hay cambios
class ProductProvider extends ChangeNotifier {
  //Instancia del servicio que se encarga de obtener los productos desde la API
  final ProductService _service = ProductService();
  //Lista donde se almacenan los productos cargados
  final List<Product> _products = [];

  bool _isLoading = false;
  //Cantidad de productos a cargar por solicitud
  final int _limit = 1000;
  bool _hasMore = true;

  List<Product> get products => _products;
  //Get para indicar si se está cargando información y si hay más productos disponibles para cargar
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  //Constructor del provider
  ProductProvider() {
    fetchProducts();
  }

  //Obtener productos desde el servicio y actualizar los listeners para que la UI se reconstruya
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
