import 'package:flutter/material.dart';

class LineaDePedidoWidget extends StatefulWidget {
  final int index;
  final String foto;

  LineaDePedidoWidget(this.index, this.foto);
  @override
  State<StatefulWidget> createState() => _LineaDePedidoWidget();
}

class _LineaDePedidoWidget extends State<LineaDePedidoWidget> {
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
        // padding: const EdgeInsets.only(bottom: 10),
        width: width,
        child: Material(
            // color: Color.fromRGBO(169, 169, 169, 0.5),
            shape: const RoundedRectangleBorder(
              // side: BorderSide(color: Color.fromRGBO(77, 17, 48, 1)),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(children: <Widget>[
              Row(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: width / 2.5,
                      height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.foto)),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    )),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                "Accesorio para auto " +
                                    widget.index.toString(),
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            Text("Precio: S/34.000",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontSize: 12,
                                    color: Colors.black)),
                            Text("Cantidad: 12",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: "Quicksand",
                                    fontSize: 12,
                                    color: Colors.black)),
                          ])),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(color: Colors.red),
              ),
            ])));
  }
}
