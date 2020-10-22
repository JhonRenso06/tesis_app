import 'package:mr_yupi/src/model/distrito.dart';
import 'package:mr_yupi/src/model/model.dart';

class Establecimiento extends Model {
  num id;
  String nombre;
  String direccion;
  String telefono;
  num latitud;
  num longitud;
  Distrito distrito;

  Establecimiento({
    this.id,
    this.nombre,
    this.direccion,
    this.telefono,
    this.latitud,
    this.longitud,
    this.distrito,
  });

  @override
  Model fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.nombre = data["nombre"];
    this.direccion = data["direccion"];
    this.telefono = data["telefono"];
    this.latitud = data["latitud"];
    this.longitud = data["longitud"];
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
      'direccion': direccion,
      'telefono': telefono,
      'latitud': latitud,
      'longitud': longitud,
      'distrito': distrito.toMap(),
    };
  }
}
