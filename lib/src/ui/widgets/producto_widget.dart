import 'package:flutter/material.dart';

class ProductoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductoWidget();
}

class _ProductoWidget extends State<ProductoWidget> {
  TextEditingController cantidadController = new TextEditingController();
  MediaQueryData pantalla;
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pantalla = MediaQuery.of(context);
    var width = pantalla.size.width / 2;
    var url =
        'https://cdn.pixabay.com/photo/2017/06/27/18/22/isolated-2448349_960_720.png';
    return Container(
        width: width,
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Material(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Column(children: <Widget>[
                  Container(
                    width: width,
                    height: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(url)),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  Text("Mustang 70",
                      style: TextStyle(fontFamily: "Quicksand", fontSize: 20)),
                  Text("S/ 34,000",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: width / 4,
                            child: ButtonTheme(
                              // minWidth: 40,
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
                                        fontFamily: "Quicksand", fontSize: 20),
                                  ),
                                ))),
                        Container(
                            width: width / 4,
                            child: ButtonTheme(
                              // minWidth: 40,
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
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                            // minWidth: 30,
                            // padding: EdgeInsets.fromLTRB(0),
                            onPressed: () {
                              print("Añadir al carrito");
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Añadir al carrito",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Quicksand",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  Icon(
                                    Icons.shopping_cart,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ])),
                      ])
                ]))));
  }
}
