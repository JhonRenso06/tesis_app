import 'package:mr_yupi/src/model/cliente.dart';

class ClienteJuridico extends Cliente {
  String razonSocial;

  ClienteJuridico({
    this.razonSocial,
    num id,
    String documento,
    String direccion,
    String telefono,
    String correo,
    String password,
  }) : super(
          id: id,
          documento: documento,
          direccion: direccion,
          telefono: telefono,
          correo: correo,
          password: password,
        );

  ClienteJuridico.fromMap(Map<String, dynamic> data)
      : this.razonSocial = data["razonSocial"],
        super.fromMap(data);
}
