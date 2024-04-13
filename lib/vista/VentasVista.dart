import 'package:flutter/material.dart';
import 'package:punto_de_venta/controller/VentasController.dart';
import 'package:punto_de_venta/modelo/Producto.dart';
import 'package:punto_de_venta/modelo/Venta.dart';

class VistaVentas extends StatefulWidget {
 
  const VistaVentas({super.key});

  @override
  State<VistaVentas> createState() => _VistaVentasState();
}

class _VistaVentasState extends State<VistaVentas> {
  final VentasController _ventasController = VentasController();

  List<Venta> get ventas => _ventasController.ventas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas Realizadas'),
      ),
      body: ListView.builder(
        itemCount: ventas.length,
        itemBuilder: (context, index) {
          Venta venta = ventas[index];
          String productosString =
              venta.productos.map((producto) => producto.nombre).join(', ');
          return ListTile(
            title: Text(
                'ID: ${venta.id} - Fecha: ${venta.fecha} - Total: ${venta.total.toString()}'),
            subtitle: Text('Productos: $productosString'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _ventasController.agregarVenta(
              [
                Producto(id: 1, nombre: 'Sabritas', precio: 10.0, cantidad: 10, categoria: 'Snaks'),
                Producto(id: 2, nombre: 'Galletas', precio: 20.0, cantidad: 20, categoria: 'Snaks'),
              ],
              30.0,
            );
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}


