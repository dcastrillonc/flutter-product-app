//Servicio para obtener los productos de la API
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const String baseUrl = 'https://fakestoreapi.com/products';

  Future<List<Product>> fetchProducts({int limit = 10, int skip = 0}) async {
    final response = await http.get(Uri.parse('$baseUrl?limit=$limit'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar productos');
    }
  }
}
