import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:punto_de_venta/vista/AlmacenVista.dart';
import 'package:punto_de_venta/vista/AltasVista.dart';
import 'package:punto_de_venta/vista/BajasVista.dart';
import 'package:punto_de_venta/vista/CarritoVista.dart';
import 'package:punto_de_venta/vista/CategoriasVista.dart';
import 'package:punto_de_venta/vista/VentasVista.dart';
void main() async {
  await Hive.initFlutter();
  await Hive.openBox('productos');
  await Hive.openBox('proveedores');
  await Hive.openBox('categorias');
  await Hive.openBox('carrito');
  await Hive.openBox('ventas');
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 192, 49, 44)),
       
      ),
      home: const MyHomePage(title: 'Tienda'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget buildButton(String text, IconData iconData, VoidCallback onPressed) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: IconButton(
      onPressed: onPressed,
      icon: Column(
        children: [
          Icon(iconData),
          SizedBox(height: 4), // Separación entre el icono y el texto
          Text(text),
        ],
      ),
      tooltip: text,
    ),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(widget.title),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildButton('Almacen', Icons.storage, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AlmacenVista(),
            ),
          );
        }),
        buildButton('Altas', Icons.add, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AltasVista(),
            ),
          );
        }),
        buildButton('Bajas', Icons.remove, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BajasVista(),
            ),
          );
        }),
        buildButton('Categorías', Icons.category, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VistaCategorias(),
            ),
          );
        }),
        buildButton('Carrito', Icons.shopping_cart, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VistaCarrito(),
            ),
          );
        }),
        buildButton('Ventas', Icons.monetization_on, () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VistaVentas(),
            ),
          );
        }),
        buildButton('Salir', Icons.exit_to_app, () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          
        }),
      ],
    ),
  );
}
}

void mostrarMensajeError(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Aviso'),
        content: Text(mensaje),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cerrar'),
          ),
        ],
      );
    },
  );
}
