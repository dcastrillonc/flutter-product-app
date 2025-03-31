//Paquete para usar JSON en Dart
import 'dart:convert';
//Paquete para realizar solicitudes HTTP
import 'package:http/http.dart' as http;
import '../models/product.dart';

//Servicio para obtener los productos de la API
class ProductService {
  //URL base de la API para obtener los productos
  static const String baseUrl = 'https://fakestoreapi.com/products';

  //Metodo para obtener los productos de la API
  Future<List<Product>> fetchProducts({int limit = 10, int skip = 0}) async {
    //Realiza solicitud GET a la API
    final response = await http.get(Uri.parse('$baseUrl?limit=$limit'));

    //Verifica si la respuesta tiene un código de estado 200 (OK)
    if (response.statusCode == 200) {
      //Decodificar la respuesta JSON de la API
      List<dynamic> data = json.decode(response.body);
      //Convertir la lista de productos JSON en una lista de objetos Product
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      //Excepción si el código de estado no es 200
      throw Exception('Error al cargar productos');
    }
  }
}
