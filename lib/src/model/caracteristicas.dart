class Caracteristicas {
  String descripcion, id;

  Caracteristicas(this.id, this.descripcion);

  Caracteristicas.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.descripcion = data["descripcion"];
  }
}
