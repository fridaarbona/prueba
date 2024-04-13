
import 'package:hive_flutter/hive_flutter.dart';
import 'package:punto_de_venta/modelo/Producto.dart';

class CarritoController {
  final List<Producto> _productosEnCarrito = [];
  var productosBox = Hive.box('productos');

  List<Producto> get productosEnCarrito => _productosEnCarrito;

  bool agregarProducto(Producto producto, int cantidad) {
    // Buscar si el producto ya está en el carrito
    int index = _productosEnCarrito.indexWhere((p) => p.id == producto.id);
    if (index != -1) {
      // Si el producto ya está en el carrito, sumar las cantidades
      _productosEnCarrito[index].cantidad += cantidad;
    } else {
      // Si el producto no está en el carrito, agregarlo
      _productosEnCarrito.add(Producto(
        id: producto.id,
        nombre: producto.nombre,
        precio: producto.precio,
        cantidad: cantidad,
        categoria: producto.categoria,
      ));
    }
    return true;
  }
  String get productosEnCadena {
    return _productosEnCarrito.map((producto) => producto.toString()).join(', ');
  }
  
  double calcularTotal() {
    return _productosEnCarrito.fold(0, (sum, producto) => sum + (producto.precio * producto.cantidad));
  }

  Producto? obtenerProductoPorId(int id) {
    for (var key in productosBox.keys) {
      var producto = productosBox.get(key);
      if (producto['id'] == id) {
        return Producto(
          id: producto['id'],
          nombre: producto['nombre'],
          precio: producto['precio'],
          cantidad: producto['cantidad'],
          categoria: producto['categoria'],
        );
      }
    }
    return null; // Retornar null si no se encuentra el producto con el ID especificado
  }
}


