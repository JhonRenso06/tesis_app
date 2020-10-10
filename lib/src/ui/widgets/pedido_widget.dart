import 'package:flutter/material.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/enums/estado_de_pedido.dart';
import 'package:mr_yupi/src/model/enums/metodo_de_pago.dart';
import 'package:mr_yupi/src/model/pedido.dart';

class PedidoWidget extends StatelessWidget {
  final Pedido pedido;
  final Function(Pedido) onTap;

  PedidoWidget(this.pedido, {this.onTap});

  @override
  Widget build(BuildContext context) {
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
        height: 160,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Pedido No ${pedido.codigo}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Detalle",
                        style: TextStyle(
                          color: Global.accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Global.accentColor,
                        size: 16,
                      )
                    ],
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
                                  Global.dateFormatter(pedido.fechaDeEmision),
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
                                    "Total",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "S/. ${pedido.total.toStringAsFixed(2)}",
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
            Container(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (this.onTap != null) {
                      this.onTap(pedido);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget textEstado() {
    Color color;
    String str = pedido.strEstado;
    switch (pedido.estado) {
      case EstadoDePedido.ATENDIDO:
        color = Colors.greenAccent[700];
        str += "\n ${Global.dateFormatter(pedido.fechaDeEntrega)}";
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
    switch (pedido.metodoDePago) {
      case MetodoDePago.TARJETA:
        return "Tarjeta";
      default:
        return "Efectivo";
    }
  }
}
