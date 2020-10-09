import 'package:mr_yupi/src/model/provincia.dart';

class Distrito {
  num id;
  String nombre;
  Provincia provincia;

  Distrito({
    this.id,
    this.nombre,
    this.provincia,
  });

  Distrito.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.nombre = data["nombre"];
    if (data["provincia"]) {
      provincia = Provincia.fromMap(data["provincia"]);
    }
  }
}
