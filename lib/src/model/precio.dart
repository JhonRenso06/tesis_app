import 'package:mr_yupi/src/model/model.dart';

class Precio extends Model {
  num id;
  num monto;
  num cantidad;

  Precio({
    this.id,
    this.monto,
    this.cantidad,
  });

  @override
  Model fromMap(Map<String, dynamic> data) {
    id = data["id"];
    monto = data["monto"];
    cantidad = data["cantidad"];
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'monto': monto,
      'cantidad': cantidad,
    };
  }
}
