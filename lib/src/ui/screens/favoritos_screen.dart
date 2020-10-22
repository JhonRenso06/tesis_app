import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/establecimiento_bloc.dart';
import 'package:mr_yupi/src/bloc/favoritos_bloc.dart';
import 'package:mr_yupi/src/bloc/productos_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/establecimiento.dart';
import 'package:mr_yupi/src/model/producto_establecimiento.dart';
import 'package:mr_yupi/src/ui/screens/producto_detalle_screen.dart';
import 'package:mr_yupi/src/ui/widgets/list_shimmer_widget.dart';
import 'package:mr_yupi/src/ui/widgets/producto_widget.dart';

class FavoritosScreen extends StatefulWidget {
  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() {
    Establecimiento establecimiento = context.bloc<EstablecimientoBloc>().state;
    context.bloc<FavoritosBloc>().initialLoad(establecimiento);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritosBloc,
        APIResponse<Paginate<ProductoEstablecimiento>>>(
      builder: (context, state) {
        if (state.loading || !state.hasData) {
          return ListShimmerWidget(
            padding:
                const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
            isGrib: true,
            maxHeigth: 350,
            itemCount: 5,
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
                "Aún no tienes productos favoritos",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          );
        }
        return gridProductos(state);
      },
    );
  }

  Widget gridProductos(APIResponse<Paginate<ProductoEstablecimiento>> state) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3 / 6,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, int index) {
                return ProductoWidget(
                  state.data.items[index],
                  onTap: _handleProduct,
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
  }

  _handleProduct(ProductoEstablecimiento producto) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProductoDetalleScreen(producto),
      ),
    );
  }

  _onRemove(int id) async {
    await context.bloc<FavoritosBloc>().removeFavorito(id);
    await context.bloc<ProductosBloc>().removeFavorito(id);
    Establecimiento establecimiento = context.bloc<EstablecimientoBloc>().state;
    context.bloc<FavoritosBloc>().initialLoadNoLoading(establecimiento);
  }
}
