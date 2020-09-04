import 'package:flutter/material.dart';
import 'package:tesis_app/src/ui/screens/pedido_detalle_screen.dart';

class PedidoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PedidoWidget();
}

class _PedidoWidget extends State<PedidoWidget> {
  TextEditingController cantidadController = new TextEditingController();
  MediaQueryData pantalla;
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pantalla = MediaQuery.of(context);
    var width = pantalla.size.width;
    return Container(
        padding: const EdgeInsets.only(bottom: 10),
        width: width,
        child: Material(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Pedido No 209674176",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // color: Color.fromRGBO(255, 87, 51, 1),
                                  fontFamily: "Quicksand"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Divider(color: Color.fromRGBO(158, 158, 156, 1))),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      "Fecha de solicitud",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          // color: Color.fromRGBO(158, 158, 156, 1)
                          color: Colors.black),
                    )),
                    Text(
                      "2020-09-20",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          // color: Color.fromRGBO(158, 158, 156, 1)
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      "Monto total",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          // color: Color.fromRGBO(158, 158, 156, 1)
                          color: Colors.black),
                    )),
                    Text(
                      "S/600",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          // color: Color.fromRGBO(158, 158, 156, 1)
                          color: Colors.black),
                    )
                  ],
                ),
              ),
              RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PedidoDetalleScreen()),
                    );
                  },
                  child: Text(
                    "Ver pedido",
                    style:
                        TextStyle(color: Colors.white, fontFamily: "Quicksand"),
                  ),
                  // color: Color.fromRGBO(255, 87, 51, 1),
                  color: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ))
            ])));
  }
}
