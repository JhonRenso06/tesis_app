import 'package:flutter/material.dart';
import 'package:mr_yupi/src/bloc/establecimiento_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/productos_bloc.dart';
import 'package:mr_yupi/src/bloc/productos_search_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';
import 'package:mr_yupi/src/ui/screens/producto_detalle_screen.dart';
import 'package:mr_yupi/src/ui/widgets/list_shimmer_widget.dart';
import 'package:mr_yupi/src/ui/widgets/producto_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProductosSearchScreen extends StatefulWidget {
  ProductosSearchScreen();

  @override
  _ProductosSearchScreenState createState() => _ProductosSearchScreenState();
}

class _ProductosSearchScreenState extends State<ProductosSearchScreen> {
  ProductosSearchBloc _bloc;
  String _search;
  TextEditingController _controller;

  @override
  void initState() {
    _search = "";
    _bloc = ProductosSearchBloc();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {
        _search = _controller.text;
      });

      if (_search.isNotEmpty) {
        Establecimiento establecimiento =
            context.bloc<EstablecimientoBloc>().state;
        _bloc.initialLoad(establecimiento, _search);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          decoration:
              InputDecoration(hintText: "¿Qué producto tiene en mente?"),
        ),
        automaticallyImplyLeading: false,
      ),
      body: _search.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  "assets/empty-box.png",
                  height: 120,
                  width: 120,
                ),
                SizedBox(
                  height: 12,
                  width: double.maxFinite,
                ),
                Text(
                  "Ingresa el nombre del producto",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            )
          : productosWidget(),
    );
  }

  Widget productosWidget() {
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        bool loadMore = _bloc.state.loadMore;
        if (scrollInfo.metrics.pixels >=
                (scrollInfo.metrics.maxScrollExtent - 200) &&
            !loadMore) {
          Establecimiento establecimiento =
              context.bloc<EstablecimientoBloc>().state;
          _bloc.loadMore(establecimiento, _search);
        }
        return true;
      },
      child: BlocBuilder<ProductosSearchBloc,
          APIResponse<Paginate<ProductoEstablecimiento>>>(
        cubit: _bloc,
        builder: (context, state) {
          if (state.loading && !state.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: ListShimmerWidget(
                    isGrib: true,
                    maxHeigth: 350,
                    itemCount: 5,
                  ),
                ),
              ],
            );
          }

          if (state.hasData && state.data.items.length == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Image.asset(
                  "assets/empty-box.png",
                  height: 120,
                  width: 120,
                ),
                SizedBox(
                  height: 12,
                  width: double.maxFinite,
                ),
                Text(
                  "No hay productos",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )
              ],
            );
          }

          return CustomScrollView(
            slivers: <Widget>[
              MultiSliver(
                pushPinnedChildren: false,
                children: [
                  SliverPadding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width / 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 3 / 6,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, int index) {
                          return ProductoWidget(
                            state.data.items[index],
                            onTap: _handleProduct,
                            onAdd: _onAdd,
                            onRemove: _onRemove,
                          );
                        },
                        childCount: state.data.items.length,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      height: 70,
                      width: double.maxFinite,
                      child: Center(
                        child: !state.loadMore
                            ? Container(
                                height: 14,
                                width: 14,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              )
                            : Container(
                                height: 17,
                                width: 17,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                ),
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  _handleProduct(ProductoEstablecimiento producto) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductoDetalleScreen(producto),
      ),
    );
  }

  _onAdd(int id) async {
    await _bloc.addFavorito(id);
    print("äsdasd");
    context.bloc<ProductosBloc>().addFavorito(id, refresh: true);
  }

  _onRemove(int id) async {
    await _bloc.removeFavorito(id);
    context.bloc<ProductosBloc>().removeFavorito(id, refresh: true);
  }
}
