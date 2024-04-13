import 'package:flutter/material.dart';
import 'package:punto_de_venta/controller/CategoriasController.dart';
import 'package:punto_de_venta/modelo/Producto.dart';

class VistaCategorias extends StatelessWidget {
  final CategoriasController _categoriasController = CategoriasController();

  @override
  Widget build(BuildContext context) {
    List<Producto> productos = _categoriasController.obtenerProductos();

    Map<String, List<Producto>> productosPorCategoria = {};
    for (var producto in productos) {
      if (!productosPorCategoria.containsKey(producto.categoria)) {
        productosPorCategoria[producto.categoria] = [];
      }
      productosPorCategoria[producto.categoria]!.add(producto);
    }

    List<String> categorias = productosPorCategoria.keys.toList();
    categorias.sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
      ),
      body: ListView.builder(
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          String categoria = categorias[index];
          List<Producto> productosDeCategoria = productosPorCategoria[categoria]!;

          productosDeCategoria.sort((a, b) => a.nombre.compareTo(b.nombre));

          // Añadir el ListTile con el nombre de la categoría
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  categoria,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: productosDeCategoria.length,
                itemBuilder: (context, index) {
                  Producto producto = productosDeCategoria[index];
                  return ListTile(
                    title: Text(producto.nombre),
                    subtitle: Text('Precio: ${producto.precio.toString()} - Cantidad: ${producto.cantidad.toString()}'),
                  );
                },
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}

