import 'package:flutter/material.dart';
import 'package:tesis_app/src/ui/screens/producto_detalle_screen.dart';

class ProductoWidget extends StatefulWidget {
  final int codigo;
  final String nombre, foto;
  final num precio;

  ProductoWidget(this.codigo, this.nombre, this.precio, this.foto);

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
    return Container(
        width: width,
        child: Material(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Column(children: <Widget>[
              MaterialButton(
                // minWidth: 30,
                // padding: EdgeInsets.fromLTRB(0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductoDetalleScreen(
                            widget.codigo,
                            widget.nombre,
                            widget.precio,
                            widget.foto)),
                  );
                },
                child: Container(
                  width: width,
                  height: 150,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(widget.foto)),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
              Text(widget.nombre.substring(0, 20) + "...",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "Quicksand", fontSize: 15)),
              Text("S/" + widget.precio.toString(),
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
            ])));
  }
}
