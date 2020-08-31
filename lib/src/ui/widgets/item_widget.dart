import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
  final int index;
  final String foto;

  ItemWidget(this.index, this.foto);
  @override
  State<StatefulWidget> createState() => _ItemWidget();
}

class _ItemWidget extends State<ItemWidget> {
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
            padding: const EdgeInsets.only(bottom: 10, top: 0),
            child: Material(
                color: Color.fromRGBO(169, 169, 169, 0.5),
                shape: const RoundedRectangleBorder(
                  // side: BorderSide(color: Color.fromRGBO(255, 87, 51, 1)),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Container(
                          width: width / 2.5,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.foto)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              width: width / 8,
                              child: ButtonTheme(
                                buttonColor: Colors.black,
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
                                            textDirection: TextDirection.ltr,
                                            color: Colors.white))),
                              )),
                          Padding(
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                  width: 60,
                                  height: 40,
                                  child: Center(
                                    child: Text(
                                      "0",
                                      style: TextStyle(
                                          fontFamily: "Quicksand",
                                          fontSize: 20),
                                    ),
                                  ))),
                          Container(
                              width: width / 8,
                              child: ButtonTheme(
                                buttonColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50))),
                                child: RaisedButton(
                                    onPressed: () {
                                      print("Add one");
                                    },
                                    child: Center(
                                        child: Icon(Icons.add,
                                            textDirection: TextDirection.rtl,
                                            color: Colors.white))),
                              )),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                ButtonTheme(
                                  buttonColor: Color.fromRGBO(255, 87, 51, 1),
                                  // height: 40,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: RaisedButton(
                                    onPressed: () {
                                      print("Eliminar del carrito");
                                    },
                                    child:
                                        Icon(Icons.delete, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                ]))));
  }
}
