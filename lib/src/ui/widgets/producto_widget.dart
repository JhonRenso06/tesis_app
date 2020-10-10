import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:mr_yupi/src/model/producto.dart';

class ProductoWidget extends StatelessWidget {
  final Producto producto;
  final Function(Producto) onTap;

  ProductoWidget(this.producto, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.70,
                    child: CachedNetworkImage(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      imageUrl: producto.fotos[0],
                      fit: BoxFit.contain,
                      placeholder: (context, _) => Shimmer.fromColors(
                        baseColor: Colors.grey[200],
                        highlightColor: Colors.grey[300],
                        enabled: true,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: constraints.maxHeight * 0.30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          producto.nombre.substring(0, 20) + "...",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                        producto.descuento != null && producto.descuento > 0
                            ? Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "S/" +
                                            producto.precio.toStringAsFixed(2),
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        " - ${producto.porcentajeDescuento.toStringAsFixed(2)}%",
                                        style: TextStyle(
                                          fontFamily: "Quicksand",
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "S/" +
                                        producto.precioDescuento
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                      fontFamily: "Quicksand",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(77, 17, 48, 1),
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                "S/" + producto.precio.toStringAsFixed(2),
                                style: TextStyle(
                                  fontFamily: "Quicksand",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              if (producto.stock <= 0)
                Container(
                  width: double.maxFinite,
                  height: constraints.maxHeight * 0.7,
                  color: Colors.white54,
                  child: Center(
                    child: Text(
                      "Agotado",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    if (this.onTap != null) {
                      this.onTap(producto);
                    }
                  },
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: LikeButton(
                  size: 30,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
