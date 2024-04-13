import 'package:flutter/material.dart';
import 'package:punto_de_venta/controller/CarritoController.dart';
import 'package:punto_de_venta/controller/VentasController.dart';
import 'package:punto_de_venta/modelo/Producto.dart';
class VistaCarrito extends StatefulWidget {

   VistaCarrito({Key? key}) : super(key: key);

  @override
  _VistaCarritoState createState() => _VistaCarritoState();
}

class _VistaCarritoState extends State<VistaCarrito> {
  final VentasController _ventasController = VentasController();
  final CarritoController _carritoController = CarritoController();
  final TextEditingController _idController = TextEditingController();
  int _cantidad = 1;
  Producto _productoSeleccionado = Producto(id: 0, nombre: '', precio: 0.0, cantidad: 0, categoria: ''); // Inicialización con valores por defecto

  @override
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Carrito de Compras'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'ID del Producto',
              ),
            ),
            ElevatedButton(
              onPressed: _buscarProducto,
              child: const Text('Buscar Producto'),
            ),
            if (_productoSeleccionado.id != 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text('Producto: ${_productoSeleccionado.nombre}'),
                  Text('Precio: ${_productoSeleccionado.precio.toString()}'),
                  Text('Cantidad Disponible: ${_productoSeleccionado.cantidad}'),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (_cantidad > 1) {
                              _cantidad--;
                            }
                          });
                        },
                      ),
                      Text(_cantidad.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            _cantidad++;
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _agregarAlCarrito();
                      setState(() {});
                      print(_carritoController.productosEnCarrito.toString());
                    },
                    child: const Text('Agregar al Carrito'),
                  ),
                ],
              ),
            const SizedBox(height: 16.0),
            const Text(
              'Productos en el Carrito',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
  shrinkWrap: true,
  itemCount: _carritoController.productosEnCarrito.length,
  itemBuilder: (context, index) {
    Producto producto = _carritoController.productosEnCarrito[index];
    return Hero(
      tag: 'producto_${producto.id}_$index', // Tag único basado en el índice
      child: ListTile(
        title: Text(producto.nombre),
        subtitle: Text('Cantidad: ${producto.cantidad.toString()}'),
      ),
    );
  },
),

          ],
        ),
      ),
    ),
    floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            setState(() {
              _ventasController.agregarVenta(_carritoController.productosEnCarrito, _carritoController.calcularTotal());
            _carritoController.productosEnCarrito.clear();
            });
            
          },
          child: const Icon(Icons.check),
        ),
        const SizedBox(height: 16.0),
        FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            _carritoController.productosEnCarrito.clear();
            setState(() {});
          },
          child: const Icon(Icons.close),
        ),
      ],
    ),
  );
}

  void _buscarProducto() {
    int id = int.tryParse(_idController.text) ?? -1;
    if (id != -1) {
      Producto? producto = _carritoController.obtenerProductoPorId(id);
      if (producto != null) {
        setState(() {
          _productoSeleccionado = producto;
          _cantidad = 1;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Producto no encontrado')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ID de producto no válido')),
      );
    }
  }

  void _agregarAlCarrito() {
    if (_carritoController.agregarProducto(_productoSeleccionado, _cantidad)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto agregado al carrito')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay suficiente stock disponible')),
      );
    }
  }
}

