class Departamento {
  num id;
  String nombre;

  Departamento.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.nombre = data["nombre"];
  }
}
