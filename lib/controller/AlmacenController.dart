import 'package:hive_flutter/hive_flutter.dart';
import 'package:punto_de_venta/modelo/Producto.dart';

class AlmacenController {
  var productos = Hive.box('productos');

  bool modificarProducto(Producto producto) {
    try {
      productos.put(producto.id, producto.toMap());
      return true; // Producto modificado correctamente
    } catch (e) {
      return false; // Error al modificar el producto
    }
  }
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
