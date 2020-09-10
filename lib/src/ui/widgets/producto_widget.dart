import 'package:flutter/material.dart';
import 'package:tesis_app/src/model/producto.dart';
import 'package:tesis_app/src/ui/screens/producto_detalle_screen.dart';

class ProductoWidget extends StatefulWidget {
  final Producto producto;

  ProductoWidget(this.producto);

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
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProductoDetalleScreen(widget.producto)),
                    );
                    setState(() {});
                  },
                  child: widget.producto.stock > 0
                      ? Container(
                          width: width,
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(widget.producto.fotos[0])),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        )
                      : Container(
                          width: width,
                          height: 150,
                          child: Center(
                              child: Text(
                            "Agotado",
                            style: TextStyle(
                                fontFamily: "Quicksand",
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.2),
                                      BlendMode.dstATop),
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(widget.producto.fotos[0])),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                        )),
              Text(widget.producto.nombre.substring(0, 20) + "...",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: "Quicksand", fontSize: 15)),
              widget.producto.descuento != null && widget.producto.descuento > 0
                  ? Column(children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("S/" + widget.producto.precioToFixed,
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  fontFamily: "Quicksand",
                                  fontSize: 15,
                                  color: Colors.grey)),
                          Text(" " + widget.producto.porcentajeDescuento,
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                      Text("S/" + widget.producto.precioDescuentoToFixed,
                          style: TextStyle(
                              fontFamily: "Quicksand",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(77, 17, 48, 1))),
                    ])
                  : Text("S/" + widget.producto.precioToFixed,
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))
            ])));
  }
}
