import 'package:flutter/material.dart';
import 'package:punto_de_venta/controller/BajasController.dart';

class BajasVista extends StatefulWidget {
  @override
  _BajasVistaState createState() => _BajasVistaState();
}

class _BajasVistaState extends State<BajasVista> {
  final TextEditingController _idController = TextEditingController();
  BajasController _bajasController = BajasController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bajas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('ID del producto a dar de baja:'),
            TextFormField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Ingrese el ID del producto',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes realizar la lógica para dar de baja el producto
                int id = int.tryParse(_idController.text) ?? 0;
                if (id > 0) {
                  // Lógica para dar de baja el producto con el ID dado
                  if (_bajasController.eliminarProducto(id)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Producto dado de baja')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Producto no encontrado')),
                    );
                  }
                }
              },
              child: const Text('Dar de baja'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }
}
