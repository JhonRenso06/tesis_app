class Provincia {
  num id;
  String nombre;

  Provincia.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    nombre = data["nombre"];
  }
}
