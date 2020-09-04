import 'package:flutter/material.dart';
import 'package:tesis_app/src/ui/widgets/linea_de_pedido_widget.dart';

class PedidoDetalleScreen extends StatefulWidget {
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
    List<String> items = [
      "https://cdn.pixabay.com/photo/2016/11/22/23/44/buildings-1851246_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/03/26/22/32/fast-1281628_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/24/14/00/christmas-tree-1856343_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/10/20/06/00/fiat-1754723_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/09/12/18/56/ifa-1665443_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/22/23/44/buildings-1851246_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/03/26/22/32/fast-1281628_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/24/14/00/christmas-tree-1856343_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/10/20/06/00/fiat-1754723_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/09/12/18/56/ifa-1665443_960_720.jpg"
    ];
    return Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2.5,
          centerTitle: false,
          title: Text("Detalle del pedido",
              style: TextStyle(
                  fontFamily: "Quicksand",
                  color: Color.fromRGBO(142, 142, 142, 1))),
          leading: MaterialButton(
              minWidth: 30,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: Color.fromRGBO(142, 142, 142, 1),
              )),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(
                    left: 5, right: 5, bottom: 20, top: 7),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return LineaDePedidoWidget(index, items[index]);
                }),
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 10, bottom: 12, left: 24, right: 24),
            width: double.maxFinite,
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Resumen de compra",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Divider(color: Colors.white),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text("Método de pago",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: "Quicksand",
                            ))),
                    Text("Pago con tarjeta de crédito",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: "Quicksand",
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Divider(color: Colors.white),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text("Subtotal",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: "Quicksand",
                            ))),
                    Text("S/10000",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: "Quicksand",
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Divider(color: Colors.white),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text("IGV",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: "Quicksand",
                            ))),
                    Text("S/10000",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: "Quicksand",
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Divider(color: Colors.white),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text("Total",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: "Quicksand",
                            ))),
                    Text("S/10000",
                        style: TextStyle(
                          color: Color.fromRGBO(255, 87, 51, 1),
                          fontSize: 10,
                          fontFamily: "Quicksand",
                        )),
                  ],
                ),
              ],
            ),
          )
        ]));
  }
}
