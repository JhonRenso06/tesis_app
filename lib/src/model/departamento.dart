import 'package:mr_yupi/src/model/provincia.dart';

class Departamento {
  num id;
  String nombre;
  List<Provincia> provincias;

  Departamento({this.id, this.nombre, this.provincias});

  Departamento.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.nombre = data["nombre"];
    provincias = List();
    if (data["provincias"] != null) {
      List<dynamic> aux = data["provincias"];
      aux.forEach((element) {
        provincias.add(Provincia.fromMap(element));
      });
    }
  }
}
