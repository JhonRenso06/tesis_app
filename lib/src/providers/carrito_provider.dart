import 'package:flutter/foundation.dart';
import 'package:mr_yupi/src/enums/metodo_de_envio.dart';
import 'package:mr_yupi/src/model/linea_de_pedido.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';

class CarritoProvider with ChangeNotifier {
  Pedido pedido;

  CarritoProvider() {
    pedido = new Pedido();
  }

  addLineaDePedido(
      int cantidad, ProductoEstablecimiento productoEstablecimiento) {
    this.pedido.addLineaDePedido(cantidad, productoEstablecimiento);
    notifyListeners();
  }

  deleteLineaDePedido(ProductoEstablecimiento productoEstablecimiento) {
    this.pedido.deleteLineaDePedido(productoEstablecimiento);
    notifyListeners();
  }

  int get cantidad => this.pedido.cantidad;
  List<LineaDePedido> get lineasDePedido => this.pedido.lineasDePedido;

  double get total => pedido.calcularTotal();

  double get subTotal => pedido.calcularSubTotal();

  double get igv => pedido.calcularIGV();

  MetodoDeEnvio get metodoDeEnvio => pedido.metodoDeEnvio;

  set metodoDeEnvio(MetodoDeEnvio val) {
    this.pedido.metodoDeEnvio = val;
    notifyListeners();
  }
}
