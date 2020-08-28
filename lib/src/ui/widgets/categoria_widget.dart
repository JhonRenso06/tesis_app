import 'package:flutter/material.dart';

class CategoriaWidget extends StatefulWidget {
  final int index;
  final String nombre, foto;

  CategoriaWidget(this.index, this.nombre, this.foto);
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
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.foto)),
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
                                  Text(
                                      widget.nombre +
                                          " " +
                                          widget.index.toString(),
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
