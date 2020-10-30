import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/establecimiento_bloc.dart';
import 'package:mr_yupi/src/bloc/productos_bloc.dart';
import 'package:mr_yupi/src/bloc/ultimo_pedido_bloc.dart';
import 'package:mr_yupi/src/global/global.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';
import 'package:mr_yupi/src/ui/screens/pedido_detalle_screen.dart';
import 'package:mr_yupi/src/ui/screens/producto_detalle_screen.dart';
import 'package:mr_yupi/src/ui/widgets/list_shimmer_widget.dart';
import 'package:mr_yupi/src/ui/widgets/pedido_widget.dart';
import 'package:mr_yupi/src/ui/widgets/producto_widget.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProductosScreen extends StatefulWidget {
  @override
  _ProductosScreenState createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreen> {
  @override
  void initState() {
    Establecimiento establecimiento = context.bloc<EstablecimientoBloc>().state;
    if (!context.bloc<ProductosBloc>().state.hasData) {
      context.bloc<ProductosBloc>().initialLoad(establecimiento);
    }
    if (!context.bloc<UltimoPedidoBloc>().state.hasData) {
      context.bloc<UltimoPedidoBloc>().loadPedido();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return productosWidget();
  }

  Widget productosWidget() {
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        bool loadMore = context.bloc<ProductosBloc>().state.loadMore;
        if (scrollInfo.metrics.pixels >=
                (scrollInfo.metrics.maxScrollExtent - 200) &&
            !loadMore) {
          Establecimiento establecimiento =
              context.bloc<EstablecimientoBloc>().state;
          context.bloc<ProductosBloc>().loadMore(establecimiento);
        }
        return true;
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: BlocBuilder<UltimoPedidoBloc, APIResponse<Pedido>>(
                builder: (context, state) {
              if (state.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
                  child: PedidoWidget(
                    state.data,
                    onTap: _toDetallePedido,
                  ),
                );
              }
              return Container(
                margin: const EdgeInsets.only(
                  left: 14,
                  right: 14,
                  top: 14,
                  bottom: 6,
                ),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/salute.png',
                      height: 50,
                      width: 50,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        "¡Bienvenido! Hoy es un buen dia para comprar",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Global.accentColor,
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                color: Colors.grey.withOpacity(0.2),
                height: 150,
                width: double.maxFinite,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          BlocBuilder<ProductosBloc,
              APIResponse<Paginate<ProductoEstablecimiento>>>(
            builder: (context, state) {
              if (state.loading && !state.hasData) {
                return SliverToBoxAdapter(
                  child: ListShimmerWidget(
                    isGrib: true,
                    maxHeigth: 350,
                    itemCount: 5,
                  ),
                );
              }

              return MultiSliver(
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
              );
            },
          ),
        ],
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
    await context.bloc<ProductosBloc>().addFavorito(id);
  }

  _onRemove(int id) async {
    await context.bloc<ProductosBloc>().removeFavorito(id);
  }

  _toDetallePedido(Pedido pedido) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PedidoDetalleScreen(pedido),
      ),
    );
  }
}
