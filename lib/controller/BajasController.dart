import 'package:hive_flutter/hive_flutter.dart';

class BajasController{
   var productos = Hive.box('productos');
     bool eliminarProducto(int id) {
  if (productos.containsKey(id)) {
    productos.delete(id);
    return true; // Producto eliminado
  } 
  return false; // Producto no encontrado
}

}