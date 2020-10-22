import 'package:mr_yupi/src/model/model.dart';

class Categoria extends Model {
  num id;
  String nombre;
  String imagen;

  Categoria({
    this.id,
    this.nombre,
    this.imagen,
  });

  @override
  Model fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.nombre = data["nombre"];
    this.imagen = data["imagen"] ?? "";
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'nombre': this.nombre,
      'imagen': this.imagen,
    };
  }
}
