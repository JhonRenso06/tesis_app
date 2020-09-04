import 'package:flutter/material.dart';

class EditarPerfilScreen extends StatefulWidget {
  @override
  _EditarPerfilScreenState createState() => _EditarPerfilScreenState();
}

class _EditarPerfilScreenState extends State<EditarPerfilScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData pantalla = MediaQuery.of(context);
    var width = pantalla.size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2.5,
          centerTitle: false,
          title: Text("Editar perfil",
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
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: width / 2.5,
                    height: width / 2.5,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: width,
                      backgroundImage: AssetImage("assets/default_user.png"),
                    ),
                  ),
                ),
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
                    hintText: "Email",
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  cursorColor: Color.fromRGBO(255, 87, 51, 1),
                  obscureText: true,
                  style: new TextStyle(fontFamily: "Quicksand", fontSize: 12.5),
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Contraseña",
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
                    hintText: "Documento (DNI o RUC)",
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
