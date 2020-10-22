import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/direccion_bloc.dart';
import 'package:mr_yupi/src/bloc/perfil_bloc.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/cliente.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/ui/screens/direccion_screen.dart';
import 'package:mr_yupi/src/ui/screens/editar_perfil_screen.dart';
import 'package:mr_yupi/src/ui/screens/login_screen.dart';
import 'package:mr_yupi/src/ui/screens/pedidos_screen.dart';
import 'package:mr_yupi/src/ui/screens/direcciones_screen.dart';
import 'package:mr_yupi/src/ui/widgets/card_shimmer_widget.dart';
import 'package:mr_yupi/src/ui/widgets/direccion_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  Direccion _predeterminado;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<PerfilBloc, APIResponse<Cliente>>(
      cubit: context.bloc<PerfilBloc>(),
      builder: (context, state) {
        if (state.loading) {
          return SizedBox.shrink();
        }
        if (!state.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/profile.png",
                height: width * 0.4,
                width: width * 0.4,
              ),
              SizedBox(
                height: 38,
                width: double.maxFinite,
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(left: 38, right: 38),
                child: OutlineButton(
                  child: Text("Iniciar sesión"),
                  onPressed: _toLogin,
                ),
              ),
            ],
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
                                            state.data.fullName,
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
                                            state.data.correo,
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
                                "assets/address.png",
                                width: 100,
                                height: 100,
                              ),
                            ),
                            Text(
                              "Mis direcciones",
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
                            onTap: _toMisDirecciones,
                          ),
                        )
                      ],
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

  _signOut() {
    context.bloc<PerfilBloc>().signOut();
  }

  _toLogin() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  _handleEdit() async {
    Cliente cliente = await context.bloc<PerfilBloc>().getCliente();
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarPerfilScreen(cliente),
      ),
    );
    if (result != null && result) {
      await context.bloc<PerfilBloc>().getCurrentClient();
    }
  }

  _toMisPedidos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PedidosScreen(),
      ),
    );
  }

  _toMisDirecciones() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DireccionesScreen(),
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
