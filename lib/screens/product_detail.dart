import 'package:flutter/material.dart';
import '../models/product.dart';

//Pantalla que muestra los detalles de un producto específico
//Recibe un objeto Product para mostrar su imagen, titulo y descripción
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  //Constructor que recibe el producto seleccionado
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detalle del producto",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      //Contenedor principal del contenido
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Imagen del producto centrada
            Center(
              child: Image.network(
                product.image,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            //Título del producto
            Text(
              product.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            //Descripción del producto
            Text(product.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
