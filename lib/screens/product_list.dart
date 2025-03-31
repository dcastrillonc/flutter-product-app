import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'product_detail.dart';

//Pantalla que muestra la lista de productos
class ProductListScreen extends StatefulWidget {
  //Constructor de la clase
  const ProductListScreen({super.key});

  //Crear el estado de la pantalla
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  //Controlador para manejar el desplazamiento en la lista de productos
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      //Listener para detectar cuando el usuario se acerca al final de la lista
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent -
                  200 && //Verificar si el usuario está cerca del final
          !Provider.of<ProductProvider>(context, listen: false).isLoading) {
        //Verificar si no hay una carga en curso
        Provider.of<ProductProvider>(
          context,
          listen: false,
        ).fetchProducts(); //Solicitar más productos
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Obtener la instancia del provider que gestiona los productos
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de productos',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.amberAccent,
        centerTitle: true,
      ),
      //Crear lista de productos
      body: ListView.builder(
        //Controlador de desplazamiento
        controller: _scrollController,
        padding: const EdgeInsets.all(8),
        itemCount:
            provider.products.length +
            (provider.isLoading ? 1 : 0), //Indicador de carga
        itemBuilder: (context, index) {
          if (index < provider.products.length) {
            //Obtener el producto correspondiente al índice
            final product = provider.products[index];
            //Crear tarjeta para cada producto
            return Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              //Elemento de lista que contiene el producto
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                //Imagen del producto
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(product.image, width: 60, height: 60),
                ),
                //Titulo del producto
                title: Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                //Icono para indicar la navegación a los detalles del producto
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                //Acción cuando el usuario selecciona un producto
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(product: product),
                    ),
                  );
                },
              ),
            );
          } else {
            //Muestra un indicador de carga mientras se obtienen más productos
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
