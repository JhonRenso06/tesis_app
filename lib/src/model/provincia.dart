import 'package:mr_yupi/src/model/departamento.dart';
import 'package:mr_yupi/src/model/distrito.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/model.dart';

class Provincia extends Model {
  String id;
  String nombre;
  Departamento departamento;
  List<Distrito> distritos;
  List<Establecimiento> establecimientos;

  Provincia({this.id, this.nombre, this.departamento, this.distritos});

  @override
  Model fromMap(Map<String, dynamic> data) {
    id = data["id"];
    nombre = data["nombre"];
    distritos = List();
    if (data["distritos"] != null) {
      List<dynamic> aux = data["distritos"];
      aux.forEach((element) {
        distritos.add(Distrito().fromMap(element));
      });
    }
    if (data["departamento"] != null) {
      departamento = Departamento().fromMap(data["departamento"]);
    }
    establecimientos = List();
    if (data["establecimientos"] != null) {
      (data["establecimientos"] as List).forEach((element) {
        establecimientos.add(Establecimiento().fromMap(element));
      });
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'departamento': departamento?.toMap(),
    };
  }
}
