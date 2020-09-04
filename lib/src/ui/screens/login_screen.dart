import 'package:flutter/material.dart';
import 'package:tesis_app/src/ui/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      color: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 80, bottom: 30, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 250.0,
              child: Image.asset(
                "assets/logo_blanco.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              obscureText: false,
              style: new TextStyle(fontSize: 20),
              decoration: InputDecoration(
                hintText: "Email",
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
              obscureText: true,
              style: new TextStyle(fontSize: 20),
              decoration: InputDecoration(
                hintText: "Contraseña",
              ),
            ),
            Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "¿Olvidaste tu contraseña?",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
            Material(
              color: Colors.black,
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (_)=>false
                  );
                },
                child: Text("Iniciar sesión",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
