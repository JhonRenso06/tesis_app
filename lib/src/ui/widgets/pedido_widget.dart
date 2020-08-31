import 'package:flutter/material.dart';

class PedidoWidget extends StatefulWidget {
  // final int index;
  // final String nombre, foto;

  // PedidoWidget(this.index, this.nombre, this.foto);
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
        width: width,
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Material(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(
                      color: Colors.black, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(children: <Widget>[
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Pedido No 209674176",
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 87, 51, 1),
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
                          "Fecha de solicitud:",
                          style: TextStyle(
                              fontFamily: "Quicksand",
                              // color: Color.fromRGBO(158, 158, 156, 1)
                              color: Colors.black
                              ),
                        )),
                        Text(
                          "2020-09-20",
                          style: TextStyle(
                              fontFamily: "Quicksand",
                              // color: Color.fromRGBO(158, 158, 156, 1)
                              color: Colors.black
                              ),
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
                          "Monto total:",
                          style: TextStyle(
                              fontFamily: "Quicksand",
                              // color: Color.fromRGBO(158, 158, 156, 1)
                              color: Colors.black
                              ),
                        )),
                        Text(
                          "S/600",
                          style: TextStyle(
                              fontFamily: "Quicksand",
                              // color: Color.fromRGBO(158, 158, 156, 1)
                              color: Colors.black
                              ),
                        )
                      ],
                    ),
                  ),
                  RaisedButton(
                      onPressed: () {
                        print("Ver detalle del pedido");
                      },
                      child: Text(
                        "Ver pedido",
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Quicksand"),
                      ),
                      // color: Color.fromRGBO(255, 87, 51, 1),
                      color: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ))
                ]))));
  }
}