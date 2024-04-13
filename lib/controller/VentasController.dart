import 'package:punto_de_venta/modelo/Producto.dart';
import 'package:punto_de_venta/modelo/Venta.dart';

class VentasController {
  final List<Venta> _ventas = [
    Venta(
      id: 1,
      fecha: '2021-10-01 10:00:00',
      total: 30.0,
      productos: [
        Producto(id: 1, nombre: 'Sabritas', precio: 10.0, cantidad: 10, categoria: 'Snaks'),
        Producto(id: 2, nombre: 'Galletas', precio: 20.0, cantidad: 20, categoria: 'Snaks'),
      ],
    )
  ];

  List<Venta> get ventas => _ventas;

  void agregarVenta(List<Producto> productos, double total) {
    DateTime now = DateTime.now();
    String fecha =
        '${now.year}-${_formatNumber(now.month)}-${_formatNumber(now.day)} ${_formatNumber(now.hour)}:${_formatNumber(now.minute)}:${_formatNumber(now.second)}';

    Venta venta = Venta(
      id: _ventas.length + 1,
      fecha: fecha,
      total: total,
      productos: productos,
    );
    print(venta.VentatosString());
    _ventas.add(venta);
  }

  void eliminarVenta(int id) {
    _ventas.removeWhere((venta) => venta.id == id);
  }

  String _formatNumber(int number) {
    return number.toString().padLeft(2, '0');
  }
}



