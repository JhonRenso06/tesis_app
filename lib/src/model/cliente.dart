import 'package:mr_yupi/src/model/enums/tipo_de_documento.dart';

class Cliente {
  String direccion, telefono, correo, documento, password;
  num id;
  TipoDeDocumento tipoDeDocumento;
  Cliente(
      {this.id,
      this.documento,
      this.direccion,
      this.telefono,
      this.correo,
      this.password});

  Cliente.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    switch (data["tipoDeDocumento"]) {
      case 'DNI':
        this.tipoDeDocumento = TipoDeDocumento.DNI;
        break;
      case 'DNI':
        this.tipoDeDocumento = TipoDeDocumento.RUC;
        break;
      default:
        this.tipoDeDocumento = TipoDeDocumento.DNI;
        break;
    }
    this.documento = data["documento"];
    this.direccion = data["direccion"];
    this.telefono = data["telefono"];
    this.correo = data["correo"];
  }
}
