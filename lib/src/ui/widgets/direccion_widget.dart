import 'package:flutter/material.dart';

class DireccionWidget extends StatefulWidget {
  // final int codigo;
  // final String nombre, foto;
  // final num precio;

  // DireccionWidget(this.codigo, this.nombre, this.precio, this.foto);

  @override
  State<StatefulWidget> createState() => _DireccionWidget();
}

class _DireccionWidget extends State<DireccionWidget> {
  TextEditingController cantidadController = new TextEditingController();
  MediaQueryData pantalla;
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pantalla = MediaQuery.of(context);
    var width = pantalla.size.width - 10;
    return Container(
      width: width,
      child: Material(
        color: Color.fromRGBO(241, 243, 244, 1),
        // color: Colors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),

        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                width: width / 3.5,
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/direccion.png")),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Manuel Arévalo III Etapa MzB21 Lt36, La Esperanza"
                                .substring(0, 30) +
                            "...",
                        style: TextStyle(
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "LA ESPERANZA, TRUJILLO, LA LIBERTAD",
                        style: TextStyle(fontFamily: "Quicksand", fontSize: 10),
                      ),
                      Text(
                        "Renso Vasquez Quiroz",
                        style: TextStyle(fontFamily: "Quicksand"),
                      ),
                      Text(
                        "Teléfono: 924182041",
                        style: TextStyle(fontFamily: "Quicksand"),
                      ),
                    ]),
              ),
            )
          ]),
          Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Divider(color: Color.fromRGBO(158, 158, 156, 1))),
          RaisedButton(
              padding: EdgeInsets.only(left: 10, right: 10),
              onPressed: () {
                print("Editar dirección");
              },
              child: Text(
                "Editar",
                style: TextStyle(color: Colors.white, fontFamily: "Quicksand"),
              ),
              // color: Color.fromRGBO(255, 87, 51, 1),
              color: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30),
              )),
        ]),
      ),
    );
  }
}
