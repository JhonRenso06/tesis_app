import 'package:mr_yupi/src/enums/tipo_de_direccion.dart';
import 'package:mr_yupi/src/model/distrito.dart';
import 'package:mr_yupi/src/model/model.dart';

class Direccion extends Model {
  num id;
  String nombre;
  String apellidos;
  String telefono;
  String descripcion;
  num latitud;
  num longitud;
  TipoDeDireccion tipo;
  String numeroDeLote;
  String departamentoOInterior;
  String urbanizacion;
  String referencia;
  bool predeterminado;
  Distrito distrito;

  Direccion({
    this.id,
    this.nombre,
    this.apellidos,
    this.telefono,
    this.descripcion,
    this.latitud,
    this.longitud,
    this.tipo,
    this.numeroDeLote,
    this.departamentoOInterior,
    this.urbanizacion,
    this.referencia,
    this.predeterminado,
    this.distrito,
  });

  String get fullDireccion {
    String full = distrito.nombre;
    if (distrito.provincia != null) {
      full += ", ${distrito.provincia.nombre}";
      if (distrito.provincia.departamento != null) {
        full += ", ${distrito.provincia.departamento.nombre}";
      }
    }
    return full;
  }

  String get fullName {
    String str = nombre;
    if (apellidos != null && apellidos.isNotEmpty) {
      str += " $apellidos";
    }
    return str;
  }

  @override
  Model fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.nombre = data["nombre"];
    this.apellidos = data["apellidos"];
    this.telefono = data["telefono"];
    this.descripcion = data["descripcion"] ?? "";
    this.latitud = data["latitud"];
    this.longitud = data["longitud"];
    this.tipo = TipoDeDireccionExtension.parse(data["tipo"]);
    this.numeroDeLote = data["numeroDeLote"];
    this.departamentoOInterior = data["departamentoOInterior"];
    this.urbanizacion = data["urbanizacion"];
    this.referencia = data["referencia"];
    this.predeterminado = data["predeterminado"];
    if (data["distrito"] != null) {
      this.distrito = Distrito().fromMap(data["distrito"]);
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'apellidos': apellidos,
      'telefono': telefono,
      'descripcion': descripcion,
      'latitud': latitud,
      'longitud': longitud,
      'tipo': tipo.index,
      'numeroDeLote': numeroDeLote,
      'departamentoOInterior': departamentoOInterior,
      'urbanizacion': urbanizacion,
      'referencia': referencia,
      'predeterminado': predeterminado,
      'distrito': distrito?.id,
    };
  }
}
