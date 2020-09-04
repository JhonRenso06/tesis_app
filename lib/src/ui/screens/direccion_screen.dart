import 'package:flutter/material.dart';

class DireccionScreen extends StatefulWidget {
  final String titulo;
  DireccionScreen(this.titulo);
  @override
  _DireccionScreenState createState() => _DireccionScreenState();
}

class _DireccionScreenState extends State<DireccionScreen> {
  @override
  String dropdownValue;
  void initState() {
    dropdownValue = "Casa";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData pantalla = MediaQuery.of(context);

    var width = pantalla.size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2.5,
          centerTitle: false,
          title: Text(widget.titulo,
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
        body: SingleChildScrollView(
            child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  cursorColor: Color.fromRGBO(255, 87, 51, 1),
                  obscureText: false,
                  style: new TextStyle(fontFamily: "Quicksand", fontSize: 12.5),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(255, 87, 51, 1)),
                    ),
                    hintText: "Nombre",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  cursorColor: Color.fromRGBO(255, 87, 51, 1),
                  obscureText: false,
                  style: new TextStyle(fontFamily: "Quicksand", fontSize: 12.5),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Apellidos",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  cursorColor: Color.fromRGBO(255, 87, 51, 1),
                  obscureText: false,
                  style: new TextStyle(fontFamily: "Quicksand", fontSize: 12.5),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Teléfono celular",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: width,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    elevation: 0,
                    underline: Container(
                      height: 1.2,
                      color: Color.fromRGBO(190, 190, 190, 1),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      "Casa",
                      "Centro",
                      "Condominio",
                      "Departamento",
                      "Galería",
                      "Local",
                      "Mercado",
                      "Oficina",
                      "Otro"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(fontFamily: "Quicksand")),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  obscureText: false,
                  style: new TextStyle(fontFamily: "Quicksand", fontSize: 12.5),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Dirección",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  obscureText: false,
                  style: new TextStyle(fontFamily: "Quicksand", fontSize: 12.5),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Nro/Lote",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  obscureText: false,
                  style: new TextStyle(fontFamily: "Quicksand", fontSize: 12.5),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Dpto./Int (opcional)",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  obscureText: false,
                  style: new TextStyle(fontFamily: "Quicksand", fontSize: 12.5),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Urbanización (opcional)",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  obscureText: false,
                  style: new TextStyle(fontFamily: "Quicksand", fontSize: 12.5),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Referencia (opcional)",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: width,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    elevation: 0,
                    underline: Container(
                      height: 1.5,
                      color: Color.fromRGBO(190, 190, 190, 1),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      "Casa",
                      "Centro",
                      "Condominio",
                      "Departamento",
                      "Galería",
                      "Local",
                      "Mercado",
                      "Oficina",
                      "Otro"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(fontFamily: "Quicksand")),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: width,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    elevation: 0,
                    underline: Container(
                      height: 1.5,
                      color: Color.fromRGBO(190, 190, 190, 1),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      "Casa",
                      "Centro",
                      "Condominio",
                      "Departamento",
                      "Galería",
                      "Local",
                      "Mercado",
                      "Oficina",
                      "Otro"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(fontFamily: "Quicksand")),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  width: width,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    elevation: 0,
                    underline: Container(
                      height: 1.5,
                      color: Color.fromRGBO(190, 190, 190, 1),
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      "Casa",
                      "Centro",
                      "Condominio",
                      "Departamento",
                      "Galería",
                      "Local",
                      "Mercado",
                      "Oficina",
                      "Otro"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: TextStyle(fontFamily: "Quicksand")),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: width / 10,
                  width: width / 2,
                  child: Material(
                    color: Colors.black,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {},
                      child: Text("Guardar",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Quicksand",
                              fontSize: 12.5,
                              color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
