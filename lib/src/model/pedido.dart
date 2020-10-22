import 'package:mr_yupi/src/enums/estado_de_pedido.dart';
import 'package:mr_yupi/src/enums/metodo_de_envio.dart';
import 'package:mr_yupi/src/enums/metodo_de_pago.dart';
import 'package:mr_yupi/src/enums/moneda.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/linea_de_pedido.dart';
import 'package:mr_yupi/src/model/model.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';

class Pedido extends Model {
  num id;
  num igv;
  num subtotal;
  num costoDeEnvio;
  num total;
  Moneda moneda;
  MetodoDePago metodoDePago;
  MetodoDeEnvio metodoDeEnvio;
  EstadoDePedido estado;
  DateTime fechaEmision;
  DateTime fechaAtendido;
  DateTime fechaCamino;
  DateTime fechaEntrega;
  DateTime fechaCancelado;
  Direccion direccion;
  List<LineaDePedido> lineasDePedido;

  Pedido({
    this.id,
    this.igv,
    this.subtotal,
    this.costoDeEnvio,
    this.total,
    this.moneda,
    this.metodoDePago,
    this.metodoDeEnvio,
    this.estado,
    this.fechaEmision,
    this.fechaAtendido,
    this.fechaCamino,
    this.fechaEntrega,
    this.fechaCancelado,
    this.direccion,
    this.lineasDePedido,
  }) {
    if (lineasDePedido == null) {
      lineasDePedido = List();
    }
  }

  addLineaDePedido(
      int cantidad, ProductoEstablecimiento productoEstablecimiento) {
    try {
      var lineaExistente = lineasDePedido.firstWhere((lineaDePedido) =>
          lineaDePedido.productoEstablecimiento.id ==
          productoEstablecimiento.id);
      lineaExistente.cantidad = cantidad;
      lineaExistente.precio = productoEstablecimiento.definirPrecio(cantidad);
      lineaExistente.subtotal = lineaExistente.calcularSubTotal();
    } catch (_) {
      LineaDePedido lineaDePedido = LineaDePedido(
        cantidad: cantidad,
        productoEstablecimiento: productoEstablecimiento,
        precio: productoEstablecimiento.definirPrecio(cantidad),
      );
      lineaDePedido.subtotal = lineaDePedido.calcularSubTotal();
      this.lineasDePedido.add(lineaDePedido);
    }
  }

  deleteLineaDePedido(ProductoEstablecimiento productoEstablecimiento) {
    lineasDePedido = lineasDePedido
        .where(
          (lineaDePedido) =>
              lineaDePedido.productoEstablecimiento.id !=
              productoEstablecimiento.id,
        )
        .toList();
  }

  get cantidad => this.lineasDePedido.length;

  double calcularTotal() {
    double total = 0;
    lineasDePedido.forEach((element) {
      total += element.calcularSubTotal();
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

  @override
  Model fromMap(Map<String, dynamic> data) {
    id = data["id"];
    igv = data["igv"] != null ? num.parse(data["igv"]) : 0;
    subtotal = data["subtotal"] != null ? num.parse(data["subtotal"]) : 0;
    costoDeEnvio =
        data["costoDeEnvio"] != null ? num.parse(data["costoDeEnvio"]) : 0;
    total = data["total"] != null ? num.parse(data["total"]) : 0;
    moneda = MonedaExtension.parse(data["moneda"]);
    metodoDePago = MetodoDePagoExtension.parse(data["metodoDePago"]);
    metodoDeEnvio = MetodoDeEnvioExtension.parse(data["metodoDeEnvio"]);
    estado = EstadoDePedidoExtension.parse(data["estado"]);
    fechaEmision = data["fechaEmision"] != null
        ? DateTime.parse(data["fechaEmision"])
        : null;
    fechaAtendido = data["fechaAtendido"] != null
        ? DateTime.parse(data["fechaAtendido"])
        : null;
    fechaCamino = data["fechaCamino"] != null
        ? DateTime.parse(data["fechaCamino"])
        : null;
    fechaEntrega = data["fechaEntrega"] != null
        ? DateTime.parse(data["fechaEntrega"])
        : null;
    fechaCancelado = data["fechaCancelado"] != null
        ? DateTime.parse(data["fechaCancelado"])
        : null;
    if (data["direccion"] != null) {
      direccion = Direccion().fromMap(data["direccion"]);
    }
    lineasDePedido = List();
    if (data["lineasDePedido"] != null) {
      (data["lineasDePedido"] as List).forEach((element) {
        lineasDePedido.add(LineaDePedido().fromMap(element));
      });
    }
    return this;
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'metodoDePago': metodoDePago?.index,
      'metodoDeEnvio': metodoDeEnvio.index,
      'direccion': direccion.id,
      'lineasDePedido': lineasDePedido
          .map(
            (e) => {
              'cantidad': e.cantidad,
              'productoEstablecimiento': e.productoEstablecimiento.id
            },
          )
          .toList(),
    };
  }
}
