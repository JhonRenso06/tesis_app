import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mr_yupi/src/model/linea_de_pedido.dart';
import 'package:shimmer/shimmer.dart';

class LineaDePedidoWidget extends StatelessWidget {
  final LineaDePedido lineaDePedido;

  LineaDePedidoWidget(this.lineaDePedido);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 100,
              height: 100,
              child: lineaDePedido.productoEstablecimiento.producto.foto != null
                  ? CachedNetworkImage(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      imageUrl:
                          lineaDePedido.productoEstablecimiento.producto.foto,
                      fit: BoxFit.contain,
                      placeholder: (context, _) => Shimmer.fromColors(
                        baseColor: Colors.grey[200],
                        highlightColor: Colors.grey[300],
                        enabled: true,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (_, __, d) =>
                          Image.asset("assets/products.png"),
                    )
                  : Image.asset("assets/products.png"),
            ),
            SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lineaDePedido.productoEstablecimiento.producto.nombre,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Cantidad",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(lineaDePedido.cantidad.toString())
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Precio",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text("S/. ${lineaDePedido.precio.toStringAsFixed(2)}")
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Subtotal",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text("S/. ${lineaDePedido.subtotal.toStringAsFixed(2)}")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
