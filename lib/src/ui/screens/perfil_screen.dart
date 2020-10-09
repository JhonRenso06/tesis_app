import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/bloc_state.dart';
import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:mr_yupi/src/model/departamento.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/model/distrito.dart';
import 'package:mr_yupi/src/model/provincia.dart';
import 'package:mr_yupi/src/ui/screens/direccion_screen.dart';
import 'package:mr_yupi/src/ui/screens/editar_perfil_screen.dart';
import 'package:mr_yupi/src/ui/screens/pedidos_screen.dart';
import 'package:mr_yupi/src/ui/widgets/direccion_widget.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
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
        predeterminado: false),
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
      predeterminado: true,
    )
  ];
  PerfilBloc _cubit;

  @override
  void initState() {
    _cubit = PerfilBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<PerfilBloc, BlocState<Cliente>>(
      cubit: _cubit,
      builder: (context, state) {
        if (state is LoadingState) {
          return Container();
        }
        if (state is LoadedState && state.message == null) {
          return Container(
            child: Text("Iniciar sesión"),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: width,
                height: width * 0.7,
                child: Stack(
                  children: [
                    Container(
                      height: width * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/background.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: width * 0.84,
                        height: width * 0.2,
                        margin: EdgeInsets.only(bottom: width * 0.1),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Global.accentColor,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          "Pablo Rafael Cruz López",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.alternate_email,
                                          color: Global.primaryColorDark,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text("pablocruz9988@hotmail.com"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Global.accentColor,
                                  ),
                                  onPressed: _handleEdit,
                                ),
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(31),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 15)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6, right: 6),
                child: SizedBox(
                  height: 124,
                  child: Card(
                    elevation: 0,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              padding: const EdgeInsets.only(
                                  left: 21, top: 21, bottom: 21),
                              child: Image.asset(
                                "assets/online-order.png",
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  "Ver mis pedidos",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Global.accentColor,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _toMisPedidos,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 8, top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Mis direcciones",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Global.accentColor,
                      ),
                      onPressed: _addDireccion,
                    )
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  enableInfiniteScroll: true,
                  autoPlay: false,
                ),
                items: direcciones.map((direccion) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: DireccionWidget(
                                direccion,
                                onEdit: _editDireccion,
                                onDelete: _deleteDireccion,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: FlatButton(
                        onPressed: _signOut,
                        child: Text("Cerrar sesión"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _signOut() async {}

  _handleEdit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarPerfilScreen(),
      ),
    );
  }

  _toMisPedidos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PedidosScreen(),
      ),
    );
  }

  _addDireccion() {}

  _editDireccion(Direccion direccion) {}

  _deleteDireccion(Direccion direccion) {}
}
