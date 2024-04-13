class Producto {
  int id;
  String nombre;
  double precio;
  int cantidad;
  String categoria;

  Producto({required this.id, required this.nombre, required this.precio, required this.cantidad, required this.categoria});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'cantidad': cantidad,
      'categoria': categoria,
    };
  }
  factory Producto.fromMap(Map<String, dynamic> map) {
    return Producto(
      id: map['id'],
      nombre: map['nombre'],
      precio: map['precio'],
      cantidad: map['cantidad'],
      categoria: map['categoria'],
    );
  }
  String toString() {
    return 'id: $id, nombre: $nombre, precio: $precio, cantidad: $cantidad, categoria: $categoria';
  }

}