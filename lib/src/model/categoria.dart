class Categoria {
  String nombre, imagen;
  num id;

  Categoria({this.id, this.nombre, this.imagen});

  Categoria.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.nombre = data["nombre"];
    this.imagen = data["imagen"];
  }
}
