import 'package:mr_yupi/src/model/model.dart';
import 'package:mr_yupi/src/model/provincia.dart';

class Departamento extends Model {
  String id;
  String nombre;
  List<Provincia> provincias;

  Departamento({this.id, this.nombre, this.provincias});

  @override
  Model fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.nombre = data["nombre"];
    this.provincias = List();
    if (data["provincias"] != null) {
      List<dynamic> aux = data["provincias"];
      aux.forEach((element) {
        provincias.add(Provincia().fromMap(element));
      });
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
}
