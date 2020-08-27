import 'package:flutter/material.dart';

class ItemWidget extends StatefulWidget {
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
    var url =
        'https://cdn.pixabay.com/photo/2017/06/27/18/22/isolated-2448349_960_720.png';
    return Container(
        width: width,
        child: Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            child: Material(
                color: Color.fromRGBO(169, 169, 169, 0.5),
                shape: const RoundedRectangleBorder(
                  // side: BorderSide(color: Color.fromRGBO(255, 87, 51, 1)),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Row(children: <Widget>[
                  Container(
                    width: width / 3,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(url)),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                  Column(
                    children: <Widget>[
                      Text("Mustang 70",
                          style:
                              TextStyle(fontFamily: "Quicksand", fontSize: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Precio: ",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text("S/ 34,000",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text(" || ",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text("Cantidad: ",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text("10",
                              style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      ),
                      Row(
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
                          ]),
                    ],
                  ),
                ]))));
  }
}
