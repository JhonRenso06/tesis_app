import 'package:mr_yupi/src/model/producto.dart';

class LineaDePedido {
  Producto producto;
  num id, precio, _cantidad, subtotal;

  LineaDePedido(
      {this.id, this.producto, this.precio, num cantidad, this.subtotal}) {
    this._cantidad = cantidad;
  }

  LineaDePedido.withProduct(int cantidad, Producto producto) {
    this._cantidad = cantidad;
    this.producto = producto;
    if (producto.descuento != null && producto.descuento > 0) {
      this.precio = producto.precioDescuento;
    } else {
      this.precio = producto.precio;
    }

    this.subtotal = this._cantidad * this.precio;
  }

  LineaDePedido.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.producto = Producto.fromMap(data["producto"]);
    this.precio = data["precio"];
    this._cantidad = data["cantidad"];
    this.subtotal = data["subtotal"];
  }

  set cantidad(num cantidad) {
    this._cantidad = cantidad;
    this.subtotal = cantidad * this.precio;
  }

  num get cantidad => this._cantidad;
}
