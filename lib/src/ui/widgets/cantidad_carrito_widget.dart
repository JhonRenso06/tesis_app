import 'package:flutter/material.dart';
import 'package:mr_yupi/src/global/global.dart';

class CantidadCarritoWidget extends StatelessWidget {
  final int cantidad;
  final Function onTap;

  CantidadCarritoWidget(this.cantidad, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: this.onTap,
      icon: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Icon(Icons.shopping_cart, size: 25),
          if (cantidad > 0)
            Container(
              width: 15,
              height: 15,
              child: Center(
                child: Text(
                  cantidad.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    color: Global.accentColor,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Global.accentColor, width: 1),
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
