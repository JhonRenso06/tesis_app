import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/direccion_bloc.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/direccion.dart';
import 'package:mr_yupi/src/ui/screens/direccion_screen.dart';
import 'package:mr_yupi/src/ui/widgets/list_shimmer_widget.dart';
import 'package:mr_yupi/src/ui/widgets/load_more_list.dart';

class DireccionesScreen extends StatefulWidget {
  final bool picker;

  DireccionesScreen({this.picker = false});

  @override
  _DireccionesScreenState createState() => _DireccionesScreenState();
}

class _DireccionesScreenState extends State<DireccionesScreen> {
  Direccion _direccionPredeterminada;

  @override
  void initState() {
    context.bloc<DireccionBloc>().initialLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Direcciones de envío"),
      ),
      body: BlocListener<DireccionBloc, APIResponse<Paginate<Direccion>>>(
        cubit: context.bloc<DireccionBloc>(),
        listener: (context, state) {
          if (!state.loading) {
            if (state.hasData) {
              try {
                setState(() {
                  _direccionPredeterminada =
                      context.bloc<DireccionBloc>().direccionDefault;
                });
              } catch (_) {}
            }
          }
        },
        child: BlocBuilder<DireccionBloc, APIResponse<Paginate<Direccion>>>(
          cubit: context.bloc<DireccionBloc>(),
          builder: (context, state) {
            if (state.loading) {
              return ListShimmerWidget(
                itemCount: 6,
                maxHeigth: 130,
              );
            }
            if (state.hasData && state.data.items.length > 0) {
              return LoadMoreList(
                loading: state.loadMore,
                onMaxScroll: () {
                  context.bloc<DireccionBloc>().loadMore();
                },
                padding: EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return _direccionDetalle(state.data.items[index]);
                },
                itemCount: state.data.items.length,
              );
            }
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/address.png",
                    height: width * .40,
                    width: width * .40,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "No tienes direcciones",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDireccion,
        child: Icon(Icons.add),
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
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.picker ? "Seleccionar" : "Editar",
                    style: TextStyle(color: Global.accentColor),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Global.accentColor,
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset(
                        "assets/direccion.png",
                        height: 80,
                        width: 80,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              direccion.descripcion,
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
                    Radio(
                      value: direccion,
                      groupValue: _direccionPredeterminada,
                      onChanged: changePredeterminado,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  changePredeterminado(Direccion value) async {
    context.bloc<DireccionBloc>().predeterminadoDireccion(value);
    setState(() {
      _direccionPredeterminada = value;
    });
    if (widget.picker) {
      Navigator.pop(context, true);
    }
  }

  _handleSelect(Direccion direccion) async {
    if (widget.picker) {
      changePredeterminado(direccion);
    } else {
      bool result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DireccionScreen(
            direccion: direccion,
          ),
        ),
      );
      if (result != null && result) {
        context.bloc<DireccionBloc>().initialLoad();
      }
    }
  }

  _addDireccion() async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DireccionScreen(),
      ),
    );
    if (result != null && result) {
      context.bloc<DireccionBloc>().initialLoad();
    }
  }
}
