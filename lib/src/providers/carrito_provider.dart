import 'package:flutter/foundation.dart';
import 'package:tesis_app/src/model/pedido.dart';
import 'package:tesis_app/src/model/producto.dart';

class CarritoProvider with ChangeNotifier {
  Pedido pedido;

  CarritoProvider() {
    pedido = new Pedido();
  }

  addLineaDePedido(int cantidad, Producto producto) {
    this.pedido.addLineaDePedido(cantidad, producto);
    notifyListeners();
  }

  get cantidad => this.pedido.cantidad;
  get lineasDePedido => this.pedido.lineasDePedido;
}
