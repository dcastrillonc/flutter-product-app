import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'screens/product_list.dart';

void main() {
  runApp(
    //Widget que permite proporcionar varios Providers a la aplicación
    MultiProvider(
      providers: [
        //Provider que gestiona el estado de los productos
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      //Ejecutar la aplicación principal con los Providers disponibles
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List App',
      debugShowCheckedModeBanner: false,
      home: ProductListScreen(),
    );
  }
}
