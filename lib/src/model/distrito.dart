class Distrito {
  num id;
  String nombre;

  Distrito.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.nombre = data["nombre"];
  }
}
