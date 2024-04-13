import 'package:flutter/material.dart';
import 'package:punto_de_venta/controller/AltasController.dart';
import 'package:punto_de_venta/modelo/Producto.dart';

class AltasVista extends StatefulWidget {
  @override
  _AltasVistaState createState() => _AltasVistaState();
}

class _AltasVistaState extends State<AltasVista> {
  final _formKey = GlobalKey<FormState>();
  final AltasController _altasController = AltasController();

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Altas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un precio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cantidadController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una cantidad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(labelText: 'Categoría'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una categoría';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Aquí puedes crear un objeto Producto con los datos ingresados
                    // y agregarlo a la base de datos o a la lista de productos
                    int id = int.parse(_idController.text);
                    String nombre = _nombreController.text;
                    double precio = double.parse(_precioController.text);
                    int cantidad = int.parse(_cantidadController.text);
                    String categoria = _categoriaController.text;

                    // Aquí puedes usar el objeto Producto con los datos obtenidos
                    Producto producto = Producto(
                      id: id,
                      nombre: nombre,
                      precio: precio,
                      cantidad: cantidad,
                      categoria: categoria,
                    );

                    // Luego, puedes agregar el producto a la base de datos o a la lista
                    // y mostrar un mensaje de éxito
                     if (_altasController.agregarProducto(producto)) {
                    // También puedes limpiar los campos de texto después de agregar el producto
                    _idController.clear();
                    _nombreController.clear();
                    _precioController.clear();
                    _cantidadController.clear();
                    _categoriaController.clear();
                    mostrarInfoProducto(producto);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('El producto ya existe')),
                    );
                  }
                  }
                },
                child: const Text('Agregar Producto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void mostrarInfoProducto(Producto producto) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Información del Producto'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ID: ${producto.id}'),
            Text('Nombre: ${producto.nombre}'),
            Text('Precio: ${producto.precio}'),
            Text('Cantidad: ${producto.cantidad}'),
            Text('Categoría: ${producto.categoria}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cerrar'),
          ),
        ],
      );
    },
  );
}
}
