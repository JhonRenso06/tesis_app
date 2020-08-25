import 'package:tesis_app/src/model/cliente.dart';

class ClienteJuridico extends Cliente {
  String razonSocial;

  ClienteJuridico(this.razonSocial, num id, String documento, String direccion,
      String telefono, String correo)
      : super(id, documento, direccion, telefono, correo);

  ClienteJuridico.fromMap(Map<String, dynamic> data)
      : this.razonSocial = data["razonSocial"],
        super.fromMap(data);
}
