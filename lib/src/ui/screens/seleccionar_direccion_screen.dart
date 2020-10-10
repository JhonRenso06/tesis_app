import 'package:flutter/material.dart';
import 'package:mr_yupi/src/model/departamento.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/distrito.dart';
import 'package:mr_yupi/src/model/provincia.dart';

class SeleccionarDireccionScreen extends StatefulWidget {
  @override
  _SeleccionarDireccionScreenState createState() =>
      _SeleccionarDireccionScreenState();
}

class _SeleccionarDireccionScreenState
    extends State<SeleccionarDireccionScreen> {
  List<Direccion> direcciones = [
    Direccion(
        direccion: "Av Túpac Amaru 1419",
        distrito: Distrito(
            id: 1,
            nombre: "Trujillo",
            provincia: Provincia(
                id: 1,
                nombre: "Trujillo",
                departamento: Departamento(id: 1, nombre: "La libertad"))),
        nombre: "Pablo Rafael",
        apellidos: "Cruz López",
        telefono: "969647526",
        tipo: TipoDireccion.CASA,
        predeterminado: false),
    Direccion(
      direccion: "Av America 2050",
      tipo: TipoDireccion.CONDOMINIO,
      distrito: Distrito(
        id: 1,
        nombre: "Trujillo",
        provincia: Provincia(
          id: 1,
          nombre: "Trujillo",
          departamento: Departamento(id: 1, nombre: "La libertad"),
        ),
      ),
      nombre: "Pablo Rafael",
      apellidos: "Cruz López",
      telefono: "969647526",
      predeterminado: true,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dirección de envío"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return _direccionDetalle(direcciones[index]);
        },
        itemCount: direcciones.length,
      ),
    );
  }

  Widget _direccionDetalle(Direccion direccion) {
    return SizedBox(
      width: double.maxFinite,
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            _handleSelect(direccion);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset(
                        "assets/direccion.png",
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleSelect(Direccion direccion) {
    Navigator.of(context).pop(direccion);
  }
}
