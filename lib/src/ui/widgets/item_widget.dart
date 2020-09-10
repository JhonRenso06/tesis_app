import 'package:flutter/material.dart';
import 'package:tesis_app/src/model/linea_de_pedido.dart';
import 'package:tesis_app/src/model/producto.dart';

class ItemWidget extends StatefulWidget {
  final LineaDePedido lineaDePedido;
  ItemWidget(this.lineaDePedido);
  @override
  State<StatefulWidget> createState() => _ItemWidget();
}

class _ItemWidget extends State<ItemWidget> {
  TextEditingController cantidadController = new TextEditingController();
  MediaQueryData pantalla;
  Producto producto;
  initState() {
    super.initState();
    producto = widget.lineaDePedido.producto;
  }

  @override
  Widget build(BuildContext context) {
    pantalla = MediaQuery.of(context);
    var width = pantalla.size.width;

    return Container(
        width: width,
        child: Material(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: width,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(producto.fotos[0])),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  )),
              Text(producto.nombre,
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Precio: S/" + producto.precioToFixed,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontSize: 12,
                          color: Colors.black)),
                  Text(" || ",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontSize: 12,
                          color: Colors.black)),
                  Text("Cantidad: " + widget.lineaDePedido.cantidad.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontSize: 12,
                          color: Colors.black)),
                ],
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(5),
                      height: 30,
                      child: Material(
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(
                              color: Color.fromRGBO(224, 224, 224, 1),
                              width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: width / 6,
                                  child: ButtonTheme(
                                    buttonColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50),
                                            bottomLeft: Radius.circular(50))),
                                    child: RaisedButton(
                                        elevation: 0,
                                        onPressed: () {
                                          print("Less one");
                                        },
                                        child: Center(
                                            child: Icon(Icons.remove,
                                                textDirection:
                                                    TextDirection.ltr,
                                                color: Colors.black))),
                                  )),
                              Container(
                                  width: width / 8,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      "0",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Quicksand",
                                          fontSize: 20),
                                    ),
                                  )),
                              Container(
                                  width: width / 6,
                                  child: ButtonTheme(
                                    buttonColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(50),
                                            bottomRight: Radius.circular(50))),
                                    child: RaisedButton(
                                        elevation: 0,
                                        onPressed: () {
                                          print("Add one");
                                        },
                                        child: Center(
                                            child: Icon(Icons.add,
                                                textDirection:
                                                    TextDirection.rtl,
                                                color: Colors.black))),
                                  )),
                            ]),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.all(5),
                        height: 30,
                        width: 60,
                        child: ButtonTheme(
                          buttonColor: Color.fromRGBO(77, 17, 48, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: RaisedButton(
                              elevation: 0,
                              onPressed: () {
                                print("Eliminar del carrito");
                              },
                              child: Center(
                                  child: Icon(Icons.delete,
                                      textDirection: TextDirection.ltr,
                                      color: Colors.white))),
                        )),
                  ]),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Divider(color: Color.fromRGBO(77, 17, 48, 1)),
              ),
            ])));
  }
}
