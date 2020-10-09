import 'package:flutter/material.dart';
import 'package:mr_yupi/src/model/categoria.dart';
import 'package:mr_yupi/src/ui/widgets/image_card_widget.dart';

class CategoriaWidget extends StatelessWidget {
  final Categoria categoria;
  final Function(Categoria) onTap;

  CategoriaWidget(this.categoria, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return ImageCardWidget(
      height: 200,
      imageUrl: categoria.imagen,
      onTap: () {
        if (onTap != null) {
          onTap(this.categoria);
        }
      },
      child: Container(
        child: Center(
          child: Text(
            categoria.nombre,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        color: Colors.black38,
      ),
    );
  }
}
