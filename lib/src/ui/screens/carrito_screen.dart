import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/src/model/linea_de_pedido.dart';
import 'package:tesis_app/src/providers/carrito_provider.dart';
import 'package:tesis_app/src/ui/widgets/item_widget.dart';

class CarritoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var carritoProvider = Provider.of<CarritoProvider>(context);
    List<LineaDePedido> lineasDePedido = carritoProvider.lineasDePedido;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.only(
                    left: 5, right: 5, bottom: 20, top: 7),
                itemCount: lineasDePedido.length,
                itemBuilder: (BuildContext context, int index) {
                  return ItemWidget(lineasDePedido[index]);
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
                // Container(height: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text("Subtotal",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Quicksand",
                                ))),
                        Text(carritoProvider.pedido.subtotal.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Quicksand",
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text("IGV",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Quicksand",
                                ))),
                        Text("S/2000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Quicksand",
                            )),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: Text("Total",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: "Quicksand",
                                ))),
                        Text("S/12000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: "Quicksand",
                            )),
                      ],
                    ),
                  ],
                ),
                Container(height: 6),
                Divider(color: Colors.white),
                Container(height: 6),
                Container(
                  height: 30,
                  child: Material(
                    color: Colors.black,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        print("Ir al método de pago");
                      },
                      child: Text("Procesar pedido",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Quicksand",
                              color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
