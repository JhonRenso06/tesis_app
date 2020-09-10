import 'package:tesis_app/src/model/direccion.dart';
import 'package:tesis_app/src/model/enums/metodo_de_pago.dart';
import 'package:tesis_app/src/model/enums/moneda.dart';
import 'package:tesis_app/src/model/enums/tipo_de_comprobante.dart';
import 'package:tesis_app/src/model/linea_de_pedido.dart';
import 'package:tesis_app/src/model/producto.dart';

class Pedido {
  num id, subtotal, igv, total, envio;
  Direccion direccion;
  DateTime fechaDeEmision;
  MetodoDePago metodoDePago;
  TipoDeComprobante tipoDeComprobante;
  Moneda moneda;
  String serieDeCorrelativo, numeroDeCorrelativo;
  List<LineaDePedido> lineasDePedido;

  Pedido(
      {this.id,
      this.subtotal,
      this.igv,
      this.total,
      this.envio,
      this.direccion,
      this.fechaDeEmision,
      this.metodoDePago,
      this.tipoDeComprobante,
      this.moneda,
      this.serieDeCorrelativo,
      this.numeroDeCorrelativo,
      this.lineasDePedido}) {
    if (this.lineasDePedido == null) {
      this.lineasDePedido = new List();
    }
  }

  Pedido.fromMap(Map<String, dynamic> data) {
    this.id = data["id"];
    this.subtotal = data["subtotal"];
    this.igv = data["igv"];
    this.total = data["total"];
    this.envio = data["envio"];
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
      this
          .lineasDePedido
          .add(new LineaDePedido.conSubtotal(cantidad, producto));
    }
  }

  get cantidad => this.lineasDePedido.length;

  // get igv => this.
}
