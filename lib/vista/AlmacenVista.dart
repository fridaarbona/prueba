import 'package:flutter/material.dart';
import 'package:punto_de_venta/controller/AlmacenController.dart';
import 'package:punto_de_venta/modelo/Producto.dart';
class AlmacenVista extends StatefulWidget {
  @override
  _AlmacenVistaState createState() => _AlmacenVistaState();
}

class _AlmacenVistaState extends State<AlmacenVista> {
  AlmacenController _almacenController = AlmacenController();

  @override
  Widget build(BuildContext context) {
    List<Producto> productos = _almacenController.obtenerProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Almacén'),
      ),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          Producto producto = productos[index];
          return ListTile(
            title: Text(producto.nombre),
            subtitle: Text('ID: ${producto.id} - Cantidad: ${producto.cantidad}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (producto.cantidad > 0) {
                        producto.cantidad--;
                        _almacenController.modificarProducto(producto);
                      }
                    });
                  },
                ),
                Text('${producto.cantidad}'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      producto.cantidad++;
                      _almacenController.modificarProducto(producto);
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
