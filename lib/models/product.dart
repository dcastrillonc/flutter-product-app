//Modelo de datos que representa un producto obtenido desde la API pública
class Product {
  //Identificador único del producto
  final int id;
  //Título o nombre del producto
  final String title;
  //Descripción del producto
  final String description;
  //URL de la imagen del producto
  final String image;

  //Constructor del modelo Product
  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  //Metodo factory que convierte la respuesta de la API (JSON) en una instancia de la clase Product
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }
}
