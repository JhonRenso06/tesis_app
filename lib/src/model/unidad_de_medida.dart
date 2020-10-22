import 'package:mr_yupi/src/model/model.dart';

class UnidadDeMedida extends Model {
  num id;
  String codigo;
  String descripcion;

  UnidadDeMedida({
    this.id,
    this.codigo,
    this.descripcion,
  });

  @override
  Model fromMap(Map<String, dynamic> data) {
    id = data["id"];
    codigo = data["codigo"];
    descripcion = data["descripcion"] ?? "";
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codigo': codigo,
      'descripcion': descripcion,
    };
  }
}
