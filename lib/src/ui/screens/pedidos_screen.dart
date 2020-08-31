import 'package:flutter/material.dart';
import 'package:tesis_app/src/ui/widgets/pedido_widget.dart';

class PedidosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> categorias = [
      "https://cdn.pixabay.com/photo/2019/07/07/14/03/fiat-4322521_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/22/23/44/buildings-1851246_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/09/12/18/56/ifa-1665443_960_720.jpg",
      "https://cdn.pixabay.com/photo/2018/05/02/09/29/auto-3368094_960_720.jpg"
    ];

    return ListView.builder(
        padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20, top: 7),
        itemCount: categorias.length,
        itemBuilder: (BuildContext context, int index) {
          return PedidoWidget();
        });
  }
}
