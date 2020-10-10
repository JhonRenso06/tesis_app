import 'package:flutter/material.dart';
import 'package:mr_yupi/src/global/global.dart';

class FinPedidoScreen extends StatefulWidget {
  @override
  _FinPedidoScreenState createState() => _FinPedidoScreenState();
}

class _FinPedidoScreenState extends State<FinPedidoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Global.primarySwatch[50],
            ],
            begin: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 250.0,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
              ),
            ),
            Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Procesando compra",
                  style: TextStyle(
                    color: Global.accentColor,
                    fontSize: 18,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
