import 'package:flutter/material.dart';
import 'package:tesis_app/src/ui/widgets/categoria_widget.dart';

class CategoriasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> categorias = [
      "https://cdn.pixabay.com/photo/2019/07/07/14/03/fiat-4322521_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/22/23/44/buildings-1851246_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/09/12/18/56/ifa-1665443_960_720.jpg",
      "https://cdn.pixabay.com/photo/2018/05/02/09/29/auto-3368094_960_720.jpg"
    ];
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight) / 2.5;
    final double itemWidth = size.width;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          GridView.count(
            crossAxisCount: 1,
            childAspectRatio: (itemWidth / itemHeight),
            controller: new ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: List.generate(categorias.length, (index) {
              return CategoriaWidget(index, "Categoría", categorias[index]);
            }),
          )
        ],
      ),
    );
  }
}
