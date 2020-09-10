import 'package:flutter/material.dart';

class CantidadCarritoWidget extends StatelessWidget {
  final int cantidad;

  CantidadCarritoWidget(this.cantidad);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Icon(Icons.shopping_cart, size: 25),
        if (cantidad > 0)
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              child: Text(
                cantidad.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
