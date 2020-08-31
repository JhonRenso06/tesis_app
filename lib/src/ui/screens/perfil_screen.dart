import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData pantalla;
    pantalla = MediaQuery.of(context);
    var width = pantalla.size.width;
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      Column(children: <Widget>[
        Container(
            width: width,
            height: width / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            )),
        Material(
          color: Color.fromRGBO(252, 249, 249, 1),
          child: Container(
              height: width / 4,
              transform: Matrix4.translationValues(0.0, -20.0, 0.0),
              child: Row(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Container(
                    width: width / 4,
                    height: width / 4,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: width,
                      backgroundImage: AssetImage("assets/default_user.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Renso Vasquez Quiroz",
                        style: TextStyle(fontSize: 15, fontFamily: "Quicksand"),
                      ),
                      Text(
                        "06 Noviembre 1998",
                        style: TextStyle(fontSize: 15, fontFamily: "Quicksand"),
                      ),
                      Text(
                        "rensovasquez2014@gmail.com",
                        style: TextStyle(fontSize: 15, fontFamily: "Quicksand"),
                      )
                    ],
                  ),
                ),
              ])),
        ),
      ]),
    ]));
  }
}
