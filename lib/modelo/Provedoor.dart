class Proveedor{
  int id;
  String nombre;
  String direccion;
  String telefono;
  String email;

  Proveedor({required this.id, required this.nombre, required this.direccion, required this.telefono, required this.email});

  factory Proveedor.fromJson(Map<String, dynamic> json) => Proveedor(
    id: json["id"],
    nombre: json["nombre"],
    direccion: json["direccion"],
    telefono: json["telefono"],
    email: json["email"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "nombre": nombre,
    "direccion": direccion,
    "telefono": telefono,
    "email": email,
  };

}