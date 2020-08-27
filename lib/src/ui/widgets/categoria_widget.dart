import 'package:flutter/material.dart';

class CategoriaWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoriaWidget();
}

class _CategoriaWidget extends State<CategoriaWidget> {
  TextEditingController cantidadController = new TextEditingController();
  MediaQueryData pantalla;
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pantalla = MediaQuery.of(context);
    var width = pantalla.size.width;
    var url =
        'https://cdn.pixabay.com/photo/2017/06/27/18/22/isolated-2448349_960_720.png';
    return Container(
        width: width,
        child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Material(
                // color: Colors.white,
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
                                  Text("CATEGORÍA 1",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Quicksand",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))
                                ])),
                      ])
                ]))));
  }
}
