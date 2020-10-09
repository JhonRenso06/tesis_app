import 'package:mr_yupi/src/model/cliente.dart';

class ClienteNatural extends Cliente {
  String nombre, apellidos;

  ClienteNatural(
      {this.nombre,
      this.apellidos,
      num id,
      String documento,
      String direccion,
      String telefono,
      String correo,
      String password})
      : super(
          id: id,
          documento: documento,
          direccion: direccion,
          telefono: telefono,
          correo: correo,
          password: password,
        );

  ClienteNatural.fromMap(Map<String, dynamic> data)
      : this.nombre = data["nombre"],
        this.apellidos = data["apellidos"],
        super.fromMap(data);
}
