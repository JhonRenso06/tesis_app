import 'package:flutter/material.dart';
import 'package:mr_yupi/src/model/caracteristicas.dart';

class CaracteristicasWidget extends StatelessWidget {
  final List<Caracteristicas> caracteristicas;
  CaracteristicasWidget(this.caracteristicas);

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = new List();
    for (var i = 0; i < caracteristicas.length; i++) {
      rows.add(TableRow(
          decoration: BoxDecoration(
              color:
                  i % 2 == 0 ? Color.fromRGBO(224, 224, 224, 1) : Colors.white),
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(caracteristicas[i].id,
                  style: TextStyle(
                      fontFamily: "Quicksand",
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(caracteristicas[i].descripcion,
                  style: TextStyle(fontFamily: "Quicksand", fontSize: 12)),
            )
          ]));
    }
    return Table(
        children: rows,
        columnWidths: {0: FlexColumnWidth(0.5), 1: FlexColumnWidth(1)});
  }
}
