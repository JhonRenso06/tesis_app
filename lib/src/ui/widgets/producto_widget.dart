import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';
import 'package:shimmer/shimmer.dart';

class ProductoWidget extends StatelessWidget {
  final ProductoEstablecimiento productoEstablecimiento;
  final Function(ProductoEstablecimiento) onTap;
  final Function(int id) onRemove;
  final Function(int id) onAdd;

  ProductoWidget(this.productoEstablecimiento,
      {this.onTap, this.onAdd, this.onRemove});

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
                    child: productoEstablecimiento.producto.foto != null
                        ? CachedNetworkImage(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            imageUrl: productoEstablecimiento.producto.foto,
                            fit: BoxFit.contain,
                            placeholder: (context, _) => Shimmer.fromColors(
                              baseColor: Colors.grey[200],
                              highlightColor: Colors.grey[300],
                              enabled: true,
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (_, __, ___) {
                              return Image.asset("assets/products.png");
                            },
                          )
                        : Image.asset("assets/products.png"),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: constraints.maxHeight * 0.30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          productoEstablecimiento.producto.nombre,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        productoEstablecimiento.producto.descuento != null &&
                                productoEstablecimiento.producto.descuento > 0
                            ? Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "S/" +
                                            productoEstablecimiento
                                                .producto.precios[0].monto
                                                .toStringAsFixed(2),
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: 15,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        " - ${productoEstablecimiento.producto.descuento.toStringAsFixed(2)}%",
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
                                        productoEstablecimiento
                                            .producto.descuento
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
                                "S/" +
                                    productoEstablecimiento
                                        .producto.precios[0].monto
                                        .toStringAsFixed(2),
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
              if (productoEstablecimiento.stock <= 0)
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
                      this.onTap(productoEstablecimiento);
                    }
                  },
                ),
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: LikeButton(
                  size: 30,
                  onTap: (value) async {
                    if (!value) {
                      if (onAdd != null) {
                        await onAdd(productoEstablecimiento.producto.id);
                      }
                      return true;
                    } else {
                      if (onRemove != null) {
                        await onRemove(productoEstablecimiento.producto.id);
                      }
                      return false;
                    }
                  },
                  isLiked: productoEstablecimiento.producto.favorito,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
