import 'package:punto_de_venta/modelo/Producto.dart';

class Venta {
  int id;
  String fecha;
  double total;
  List<Producto> productos;

  Venta({required this.id, required this.fecha, required this.total, required this.productos});

  Map<String, dynamic> toMap() => {
    'id': id,
    'fecha': fecha,
    'total': total,
    'productos': productos.map((producto) => producto.toMap()).toList(),
  };

  factory Venta.fromMap(Map<String, dynamic> map) => Venta(
    id: map['id'],
    fecha: map['fecha'],
    total: map['total'],
    productos: List<Producto>.from(map['productos'].map((producto) => Producto.fromMap(producto))),
  );
  VentatosString() {
    return 'id: $id, fecha: $fecha, total: $total, productos: ${productos.map((producto) => producto.toString()).join(', ')}';
  }
}
