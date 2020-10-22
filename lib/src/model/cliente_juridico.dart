import 'package:mr_yupi/src/enums/tipo_de_documento.dart';
import 'package:mr_yupi/src/model/cliente.dart';

class ClienteJuridico extends Cliente {
  String razonSocial;

  ClienteJuridico({
    this.razonSocial,
    num id,
    String documento,
    String telefono,
    String correo,
    String password,
  }) : super(
          id: id,
          documento: documento,
          telefono: telefono,
          correo: correo,
          password: password,
        ) {
    super.tipoDeDocumento = TipoDeDocumento.RUC;
  }
}
