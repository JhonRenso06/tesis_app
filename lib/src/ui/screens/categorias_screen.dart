import 'package:flutter/material.dart';
import 'package:mr_yupi/src/model/categoria.dart';
import 'package:mr_yupi/src/ui/widgets/categoria_widget.dart';

class CategoriasScreen extends StatelessWidget {
  List<Categoria> categorias = [
    Categoria(
      id: 0,
      nombre: "Bebidas",
      imagen:
          "https://dam.cocinafacil.com.mx/wp-content/uploads/2019/06/Bebidas-para-combatir-el-calor.jpg",
    ),
    Categoria(
      id: 0,
      nombre: "Gaseosas",
      imagen:
          "https://sites.google.com/site/depositodelicoresygaseosas/_/rsrc/1535240855985/gaseosas-y-jugos/banner%20%20gasesas.jpg",
    ),
    Categoria(
      id: 0,
      nombre: "Vinos",
      imagen:
          "https://www.hotelvinasqueirolo.com/blog/wp-content/uploads/2019/09/Valle-de-Ica-Tierra-de-vinos-y-piscos-peruanos-A.jpg",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(6),
      itemCount: categorias.length,
      itemBuilder: (BuildContext context, int index) {
        return CategoriaWidget(
          categorias[index],
          onTap: _onTap,
        );
      },
    );
  }

  _onTap(Categoria categoria) {}
}
