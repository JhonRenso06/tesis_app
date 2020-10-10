import 'package:flutter/material.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/caracteristicas.dart';

class CaracteristicasWidget extends StatelessWidget {
  final List<Caracteristicas> caracteristicas;
  CaracteristicasWidget(this.caracteristicas);

  @override
  Widget build(BuildContext context) {
    List<TableRow> rows = new List();
    for (var i = 0; i < caracteristicas.length; i++) {
      rows.add(
        TableRow(
          decoration: BoxDecoration(
            color: i % 2 == 0 ? Colors.grey : Colors.white,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                caracteristicas[i].id,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: i % 2 == 0 ? Colors.white : Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                caracteristicas[i].descripcion,
                style: TextStyle(
                  fontSize: 14,
                  color: i % 2 == 0 ? Colors.white : Colors.black,
                ),
              ),
            )
          ],
        ),
      );
    }
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Table(
        children: rows,
        columnWidths: {0: FlexColumnWidth(0.5), 1: FlexColumnWidth(1)},
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
