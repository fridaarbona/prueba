import 'package:hive_flutter/hive_flutter.dart';
import 'package:punto_de_venta/modelo/Producto.dart';

class AltasController{

   var productos = Hive.box('productos');
  

  bool agregarProducto(Producto producto) {
    if (!productos.containsKey(producto.id)) {
         productos.put(producto.id, producto.toMap());
        return true; 
    } else {
        
        return false; 
    }
}

}