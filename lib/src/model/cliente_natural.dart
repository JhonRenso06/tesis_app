import 'package:tesis_app/src/model/cliente.dart';

class ClienteNatural extends Cliente {
  String nombre, apellidos;

  ClienteNatural(this.nombre, this.apellidos, num id, String documento,
      String direccion, String telefono, String correo)
      : super(id, documento, direccion, telefono, correo);

  ClienteNatural.fromMap(Map<String, dynamic> data)
      : this.nombre = data["nombre"],
        this.apellidos = data["apellidos"],
        super.fromMap(data);
}
