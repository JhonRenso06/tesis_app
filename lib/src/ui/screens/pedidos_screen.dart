import 'package:flutter/material.dart';

class PedidosScreen extends StatelessWidget {
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
            Text("Pedidos")
          ],
        ),
      ),
    ));
  }
}
