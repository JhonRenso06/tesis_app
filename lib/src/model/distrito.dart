import 'package:mr_yupi/src/model/model.dart';
import 'package:mr_yupi/src/model/provincia.dart';

class Distrito extends Model {
  String id;
  String nombre;
  Provincia provincia;

  Distrito({
    this.id,
    this.nombre,
    this.provincia,
  });

  @override
  Model fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.nombre = data["nombre"];
    if (data["provincia"] != null) {
      provincia = Provincia().fromMap(data["provincia"]);
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'provincia': provincia?.toMap(),
    };
  }
}
