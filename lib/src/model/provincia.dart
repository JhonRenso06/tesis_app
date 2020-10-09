import 'package:mr_yupi/src/model/departamento.dart';
import 'package:mr_yupi/src/model/distrito.dart';

class Provincia {
  num id;
  String nombre;
  Departamento departamento;
  List<Distrito> distritos;

  Provincia({
    this.id,
    this.nombre,
    this.departamento,
  });

  Provincia.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    nombre = data["nombre"];
    distritos = List();
    if (data["distritos"] != null) {
      List<dynamic> aux = data["distritos"];
      aux.forEach((element) {
        distritos.add(Distrito.fromMap(element));
      });
    }
    if (data["departamento"]) {
      departamento = Departamento.fromMap(data["departamento"]);
    }
  }
}
