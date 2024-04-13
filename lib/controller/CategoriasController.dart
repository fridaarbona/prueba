import 'package:hive_flutter/hive_flutter.dart';
import 'package:punto_de_venta/modelo/Producto.dart';

class CategoriasController {
  var productos = Hive.box('productos');
  
List<Producto> obtenerProductos() {
  List<Producto> listaProductos = [];
  for (var key in productos.keys) {
    var producto = productos.get(key);
    String nombre = producto['nombre'] ?? ''; // Si producto['nombre'] es nulo, se asigna ''
    double precio = producto['precio'] ?? 0.0; // Si producto['precio'] es nulo, se asigna 0.0
    String categoria = producto['categoria'] ?? ''; // Si producto['categoria'] es nulo, se asigna ''
    int cantidad = producto['cantidad'] ?? 0; // Si producto['cantidad'] es nulo, se asigna 0
    listaProductos.add(Producto(
      id: producto['id'],
      nombre: nombre,
      precio: precio,
      cantidad: cantidad,
      categoria: categoria,
    ));
  }
  return listaProductos;
}
}
