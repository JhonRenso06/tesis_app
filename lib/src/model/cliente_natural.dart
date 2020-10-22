import 'package:mr_yupi/src/enums/tipo_de_documento.dart';
import 'package:mr_yupi/src/model/cliente.dart';

class ClienteNatural extends Cliente {
  String nombre;
  String apellidos;

  ClienteNatural({
    num id,
    String documento,
    String telefono,
    String correo,
    String password,
    this.nombre,
    this.apellidos,
  }) : super(
          id: id,
          documento: documento,
          telefono: telefono,
          correo: correo,
          password: password,
        ) {
    super.tipoDeDocumento = TipoDeDocumento.DNI;
  }
}
