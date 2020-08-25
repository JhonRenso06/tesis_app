import 'package:tesis_app/src/model/producto.dart';

class LineaDePedido {
  Producto producto;
  num id, precio, cantidad, subtotal;

  LineaDePedido(
      this.id, this.producto, this.precio, this.cantidad, this.subtotal);

  LineaDePedido.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.producto = Producto.fromMap(data["producto"]);
    this.precio = data["precio"];
    this.cantidad = data["cantidad"];
    this.subtotal = data["subtotal"];
  }
}
