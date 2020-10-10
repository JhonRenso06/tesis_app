import 'package:flutter/material.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/enums/estado_de_pedido.dart';
import 'package:mr_yupi/src/model/enums/metodo_de_pago.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/ui/widgets/linea_de_pedido_widget.dart';

class PedidoDetalleScreen extends StatefulWidget {
  final Pedido pedido;

  PedidoDetalleScreen(this.pedido);

  @override
  _PedidoDetalleScreenState createState() => _PedidoDetalleScreenState();
}

class _PedidoDetalleScreenState extends State<PedidoDetalleScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de pedido"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _resumenDeCompra,
              _direccionDetalle,
            ]..addAll(
                widget.pedido.lineasDePedido
                    .map(
                      (e) => LineaDePedidoWidget(e),
                    )
                    .toList(),
              ),
          ),
        ),
      ),
    );
  }

  Widget get _resumenDeCompra {
    return Card(
      color: Colors.white,
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Container(
        width: double.maxFinite,
        height: 180,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Pedido No ${widget.pedido.codigo}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    color: Color.fromRGBO(158, 158, 156, 1),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Fecha de solicitud",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  Global.dateFormatter(
                                      widget.pedido.fechaDeEmision),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Método de pago",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  metodoDePago(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Subtotal",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "S/. ${widget.pedido.subtotal.toStringAsFixed(2)}",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "I.G.V.",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "S/. ${widget.pedido.igv.toStringAsFixed(2)}",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Total",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "S/. ${widget.pedido.total.toStringAsFixed(2)}",
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/status.png",
                              width: 50,
                              height: 50,
                            ),
                            textEstado()
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _direccionDetalle {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Image.asset(
                      "assets/direccion.png",
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.pedido.direccion.direccion,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.pedido.direccion.fullDireccion,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            widget.pedido.direccion.fullName,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.pedido.direccion.telefono,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textEstado() {
    Color color;
    String str = widget.pedido.strEstado;
    switch (widget.pedido.estado) {
      case EstadoDePedido.ATENDIDO:
        color = Colors.greenAccent[700];
        str += "\n ${Global.dateFormatter(widget.pedido.fechaDeEntrega)}";
        break;
      case EstadoDePedido.CANCELADO:
        color = Colors.red;
        break;
      default:
        color = Colors.blue;
        break;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        str,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  String metodoDePago() {
    switch (widget.pedido.metodoDePago) {
      case MetodoDePago.TARJETA:
        return "Tarjeta";
      default:
        return "Efectivo";
    }
  }
}
