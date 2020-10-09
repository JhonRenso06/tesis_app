import 'package:flutter/foundation.dart';
import 'package:mr_yupi/src/model/linea_de_pedido.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/model/producto.dart';

class CarritoProvider with ChangeNotifier {
  Pedido pedido;

  CarritoProvider() {
    pedido = new Pedido();
  }

  addLineaDePedido(int cantidad, Producto producto) {
    this.pedido.addLineaDePedido(cantidad, producto);
    notifyListeners();
  }

  deleteLineaDePedido(Producto producto) {
    this.pedido.deleteLineaDePedido(producto);
    notifyListeners();
  }

  int get cantidad => this.pedido.cantidad;
  List<LineaDePedido> get lineasDePedido => this.pedido.lineasDePedido;

  double get total => pedido.calcularTotal();

  double get subTotal => pedido.calcularSubTotal();

  double get igv => pedido.calcularIGV();
}
