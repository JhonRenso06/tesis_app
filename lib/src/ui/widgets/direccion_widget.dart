import 'package:flutter/material.dart';
import 'package:mr_yupi/src/model/direccion.dart';

class DireccionWidget extends StatelessWidget {
  final Direccion direccion;
  final Function(Direccion) onEdit, onDelete;
  final Function(Direccion) onPredeterminado;
  final Direccion predeterminado;

  DireccionWidget(this.direccion,
      {this.onDelete, this.onEdit, this.onPredeterminado, this.predeterminado});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text("Dirección predeterminada"),
                  ),
                ),
                Radio<Direccion>(
                  value: direccion,
                  groupValue: predeterminado,
                  onChanged: onPredeterminado,
                ),
              ],
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Image.asset(
                      "assets/direccion.png",
                      height: width * 0.2,
                      width: width * 0.2,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          direccion.direccion,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          direccion.fullDireccion,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          direccion.fullName,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          direccion.telefono,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      if (onEdit != null) {
                        onEdit(direccion);
                      }
                    },
                    child: Text("Editar"),
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      if (onDelete != null) {
                        onDelete(direccion);
                      }
                    },
                    child: Text("Eliminar"),
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
