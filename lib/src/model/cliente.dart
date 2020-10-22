import 'package:mr_yupi/src/enums/tipo_de_documento.dart';
import 'package:mr_yupi/src/model/cliente_juridico.dart';
import 'package:mr_yupi/src/model/cliente_natural.dart';
import 'package:mr_yupi/src/model/model.dart';

class Cliente extends Model {
  num id;
  String documento;
  String telefono;
  TipoDeDocumento tipoDeDocumento;
  String correo;
  String password;

  Cliente({
    this.id,
    this.documento,
    this.telefono,
    this.tipoDeDocumento,
    this.correo,
    this.password,
  });

  String get fullName {
    if (this is ClienteJuridico) {
      return (this as ClienteJuridico).razonSocial ?? "";
    } else if (this is ClienteNatural) {
      String str = (this as ClienteNatural).nombre;
      if ((this as ClienteNatural).apellidos != null) {
        str += " ${(this as ClienteNatural).apellidos}";
      }
      return str;
    } else {
      return "";
    }
  }

  @override
  Model fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.documento = data["documento"];
    this.telefono = data["telefono"];
    this.tipoDeDocumento =
        TipoDeDocumentoExtension.parse(data["tipoDeDocumento"]);
    this.correo = data["correo"];
    if (this is ClienteJuridico) {
      (this as ClienteJuridico).razonSocial = data["nombre"];
    } else if (this is ClienteNatural) {
      (this as ClienteNatural).nombre = data["nombre"];
      (this as ClienteNatural).apellidos = data["apellidos"];
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': this.id,
      'documento': this.documento,
      'telefono': this.telefono,
      'tipoDeDocumento': this.tipoDeDocumento.index,
      'correo': this.correo,
      'password': this.password,
    };
    if (this is ClienteJuridico) {
      map["nombre"] = (this as ClienteJuridico).razonSocial;
    } else if (this is ClienteNatural) {
      map["nombre"] = (this as ClienteNatural).nombre;
      map["apellidos"] = (this as ClienteNatural).apellidos;
    }
    return map;
  }
}
