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
import 'package:rflutter_alert/rflutter_alert.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  Direccion _predeterminado;

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
  PerfilBloc _cubit;

  @override
  void initState() {
    _cubit = PerfilBloc();
    _predeterminado = direcciones[1];
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
                                        Expanded(
                                          child: Text(
                                            "Pablo Rafael Cruz López",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
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
                                        Expanded(
                                          child: Text(
                                            "pablocruz9988@hotmail.com",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 21, top: 21, bottom: 21),
                              child: Image.asset(
                                "assets/online-order.png",
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Text(
                              "Ver mis pedidos",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Global.accentColor,
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
              if (direcciones.length > 0)
                CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    autoPlay: false,
                  ),
                  items: direcciones.map((direccion) {
                    return DireccionWidget(
                      direccion,
                      onEdit: _editDireccion,
                      onDelete: _deleteDireccion,
                      onPredeterminado: _changePredeterminado,
                      predeterminado: _predeterminado,
                    );
                  }).toList(),
                )
              else
                SizedBox(
                  height: 180,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                    ),
                    child: Material(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: _addDireccion,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Global.accentColor,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Agrega una dirección",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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

  _addDireccion() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DireccionScreen(),
      ),
    );
  }

  _editDireccion(Direccion direccion) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DireccionScreen(direccion: direccion),
      ),
    );
  }

  _deleteDireccion(Direccion direccion) async {
    bool result = await Alert(
        context: context,
        title: "Cofirmación",
        desc: "¿Está seguro que quiere eliminar esta dirección?",
        type: AlertType.info,
        buttons: [
          DialogButton(
            child: Text(
              "Si",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => {Navigator.pop(context, true)},
          ),
          DialogButton(
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => {Navigator.pop(context, false)},
          )
        ]).show();
    if (result != null && result == true) {}
  }

  _changePredeterminado(Direccion direccion) {
    setState(() {
      _predeterminado = direccion;
    });
  }
}
