import 'package:mr_yupi/src/model/model.dart';

class Caracteristica extends Model {
  String clave;
  String valor;

  Caracteristica({
    this.clave,
    this.valor,
  });

  @override
  Model fromMap(Map<String, dynamic> data) {
    this.clave = data["clave"];
    this.valor = data["valor"];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'clave': clave,
      'valor': valor,
    };
  }
}
