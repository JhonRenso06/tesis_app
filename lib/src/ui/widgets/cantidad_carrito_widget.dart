import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/carrito_bloc.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/pedido.dart';

class CantidadCarritoWidget extends StatelessWidget {
  final Function onTap;

  CantidadCarritoWidget({this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarritoBloc, Pedido>(
      builder: (context, state) {
        if (state != null) {
          return button(state.lineasDePedido.length);
        }
        return button(0);
      },
    );
  }

  Widget button(int cantidad) {
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
