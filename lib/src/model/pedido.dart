import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/enums/estado_de_pedido.dart';
import 'package:mr_yupi/src/model/enums/metodo_de_pago.dart';
import 'package:mr_yupi/src/model/enums/moneda.dart';
import 'package:mr_yupi/src/model/enums/tipo_de_comprobante.dart';
import 'package:mr_yupi/src/model/linea_de_pedido.dart';
import 'package:mr_yupi/src/model/producto.dart';

class Pedido {
  num id, subtotal, igv, total;
  bool delivery;
  Direccion direccion;
  DateTime fechaDeEmision;
  DateTime fechaDeEntrega;
  MetodoDePago metodoDePago;
  TipoDeComprobante tipoDeComprobante;
  Moneda moneda;
  String serieDeCorrelativo, numeroDeCorrelativo;
  List<LineaDePedido> lineasDePedido;
  EstadoDePedido estado;

  Pedido({
    this.id,
    this.subtotal,
    this.igv,
    this.total,
    this.delivery,
    this.direccion,
    this.fechaDeEmision,
    this.metodoDePago,
    this.tipoDeComprobante,
    this.moneda,
    this.serieDeCorrelativo,
    this.numeroDeCorrelativo,
    this.estado,
    this.lineasDePedido,
    this.fechaDeEntrega,
  }) {
    if (this.lineasDePedido == null) {
      this.lineasDePedido = new List();
    }
  }

  Pedido.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.subtotal = data["subtotal"];
    this.igv = data["igv"];
    this.total = data["total"];
    this.delivery = data["delivery"];
    this.direccion = data["direccion"];
    this.fechaDeEmision =
        DateTime.fromMillisecondsSinceEpoch(data["fechaDeEmision"] * 1000);
    switch (data["metodoDePago"]) {
      case 'TARJETA':
        this.metodoDePago = MetodoDePago.TARJETA;
        break;
      case 'EFECTIVO':
        this.metodoDePago = MetodoDePago.EFECTIVO;
        break;
      default:
        this.metodoDePago = MetodoDePago.EFECTIVO;
        break;
    }
    switch (data["tipoDeComprobante"]) {
      case 'BOLETA':
        this.tipoDeComprobante = TipoDeComprobante.BOLETA;
        break;
      case 'FACTURA':
        this.tipoDeComprobante = TipoDeComprobante.FACTURA;
        break;
      default:
        this.tipoDeComprobante = TipoDeComprobante.BOLETA;
        break;
    }
    this.moneda = data["moneda"];
    switch (data["moneda"]) {
      case 'SOLES':
        this.moneda = Moneda.SOLES;
        break;
      case 'DOLARES':
        this.moneda = Moneda.DOLARES;
        break;
      default:
        this.moneda = Moneda.SOLES;
        break;
    }
    this.serieDeCorrelativo = data["serieDeCorrelativo"];
    this.numeroDeCorrelativo = data["numeroDeCorrelativo"];

    this.lineasDePedido = new List();
    if (data["lineasDePedido"] != null) {
      List<dynamic> lineasDePedidoAux = data["lineasDePedido"];
      lineasDePedidoAux.forEach((element) {
        this.lineasDePedido.add(new LineaDePedido.fromMap(element));
      });
    }
  }

  addLineaDePedido(int cantidad, Producto producto) {
    try {
      var lineaExistente = lineasDePedido.firstWhere(
          (lineaDePedido) => lineaDePedido.producto.id == producto.id);
      lineaExistente.cantidad = cantidad;
    } catch (_) {
      this.lineasDePedido.add(LineaDePedido.withProduct(cantidad, producto));
    }
  }

  deleteLineaDePedido(Producto producto) {
    lineasDePedido = lineasDePedido
        .where(
          (lineaDePedido) => lineaDePedido.producto.id != producto.id,
        )
        .toList();
  }

  get cantidad => this.lineasDePedido.length;

  double calcularTotal() {
    double total = 0;
    lineasDePedido.forEach((element) {
      total += element.cantidad * element.precio;
    });
    return total;
  }

  double calcularSubTotal() {
    return calcularTotal() / 1.18;
  }

  double calcularIGV() {
    return calcularSubTotal() * 0.18;
  }

  String get codigo {
    if (id != null) {
      String str = id.toString();
      while (str.length < 9) {
        str = "0" + str;
      }
      return str;
    }
    return "";
  }

  String get strEstado {
    switch (estado) {
      case EstadoDePedido.EN_PROCESO:
        return "En proceso";
      case EstadoDePedido.ATENDIDO:
        return "Atendido";
      case EstadoDePedido.EN_CAMINO:
        return "En camino";
      case EstadoDePedido.ENTREGADO:
        return "Entregado";
      case EstadoDePedido.CANCELADO:
        return "Cancelado";
    }
  }
}
