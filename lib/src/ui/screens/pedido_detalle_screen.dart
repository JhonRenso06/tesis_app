import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:mr_yupi/src/bloc/pedido_bloc.dart';
import 'package:mr_yupi/src/enums/estado_de_pedido.dart';
import 'package:mr_yupi/src/enums/metodo_de_pago.dart';
import 'package:mr_yupi/src/enums/tipo_de_comprobante.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/ui/widgets/carouselBancos.dart';
import 'package:mr_yupi/src/ui/widgets/linea_de_pedido_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              if (widget.pedido.metodoDePago == MetodoDePago.TRANSFERENCIA)
                Card(
                  color: Colors.white,
                  elevation: 0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: CarouselBancos(),
                ),
              Card(
                color: Colors.white,
                elevation: 0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
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
                              "assets/document.png",
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
                                    widget.pedido.tipoDeDocumento.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.pedido.clienteDocumento ?? "",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    widget.pedido.clienteRazonSocial ?? "",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (widget.pedido.tipoDeDocumento ==
                                      TipoDeComprobante.FACTURA)
                                    Text(
                                      widget.pedido.clienteDireccionFiscal,
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
              if (widget.pedido.direccion != null)
                _direccionDetalle
              else
                SizedBox(
                  width: double.maxFinite,
                  child: Card(
                    elevation: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        "Recoger en tienda",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
            ]
              ..addAll(
                widget.pedido.lineasDePedido.map(
                  (e) {
                    print(e.id);
                    return LineaDePedidoWidget(e);
                  },
                ).toList(),
              )
              ..add(
                widget.pedido.estado == EstadoDePedido.EN_PROCESO
                    ? Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: OutlineButton(
                          onPressed: _cancelarPedido,
                          child: Text("Cancelar pedido"),
                        ),
                      )
                    : SizedBox.shrink(),
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
        height: 200,
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
                                      widget.pedido.fechaEmision),
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
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Costo de envío",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  "S/. ${widget.pedido.costoDeEnvio?.toStringAsFixed(2)}",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: textEstado(),
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
                            widget.pedido.direccion.descripcion,
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

  _cancelarPedido() async {
    bool result = await Alert(
        context: context,
        title: "Confirmación",
        desc: "¿Está seguro que quiere cancelar su pedido?",
        type: AlertType.warning,
        buttons: [
          DialogButton(
            child: Text(
              "Si",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => {Navigator.pop(context, true)},
          ),
          DialogButton(
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => {Navigator.pop(context, false)},
          )
        ]).show();
    if (result != null && result) {
      Alert(
          context: context,
          title: "Cancelando pedido",
          content: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: CircularProgressIndicator(),
          ),
          type: AlertType.none,
          onWillPopActive: true,
          closeFunction: () {},
          closeIcon: Icon(
            Icons.close,
            color: Colors.transparent,
          ),
          buttons: []).show();
      await context.bloc<PedidoBloc>().cancelar(widget.pedido);
      context.bloc<PedidoBloc>().initialLoad();
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  List<Widget> textEstado() {
    Color color;
    String str = widget.pedido.estado.name;
    String imagen;
    switch (widget.pedido.estado) {
      case EstadoDePedido.ATENDIDO:
        color = Colors.blue;
        str += "\n ${Global.dateFormatter(widget.pedido.fechaAtendido)}";
        imagen = "assets/immigration.png";
        break;
      case EstadoDePedido.EN_CAMINO:
        color = Colors.yellow;
        str += "\n ${Global.dateFormatter(widget.pedido.fechaCamino)}";
        imagen = "assets/delivery_truck.png";
        break;
      case EstadoDePedido.ENTREGADO:
        color = Colors.greenAccent[700];
        str += "\n ${Global.dateFormatter(widget.pedido.fechaEntrega)}";
        imagen = "assets/delivery_box.png";
        break;
      case EstadoDePedido.CANCELADO:
        color = Colors.red;
        str += "\n ${Global.dateFormatter(widget.pedido.fechaCancelado)}";
        imagen = "assets/cancel.png";
        break;
      default:
        color = Colors.blueGrey;
        str += "\n ${Global.dateFormatter(widget.pedido.fechaEmision)}";
        imagen = "assets/order.png";
        break;
    }
    return [
      Image.asset(
        imagen,
        width: 50,
        height: 50,
      ),
      Padding(
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
      )
    ];
  }

  String metodoDePago() {
    return widget.pedido.metodoDePago.name;
  }
}
