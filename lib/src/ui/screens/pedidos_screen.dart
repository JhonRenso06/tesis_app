import 'package:flutter/material.dart';
import 'package:mr_yupi/src/bloc/pedido_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/pedido.dart';
import 'package:mr_yupi/src/ui/screens/pedido_detalle_screen.dart';
import 'package:mr_yupi/src/ui/widgets/list_shimmer_widget.dart';
import 'package:mr_yupi/src/ui/widgets/load_more_list.dart';
import 'package:mr_yupi/src/ui/widgets/pedido_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PedidosScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidosScreen> {
  @override
  void initState() {
    context.bloc<PedidoBloc>().initialLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis pedidos"),
      ),
      body: BlocBuilder<PedidoBloc, APIResponse<Paginate<Pedido>>>(
        builder: (context, state) {
          if (state.loading) {
            return ListShimmerWidget(
              itemCount: 6,
              maxHeigth: 200,
            );
          }
          if (state.hasData && state.data.items.length > 0) {
            return LoadMoreList(
              loading: state.loadMore,
              onMaxScroll: () {
                if (!state.loadMore) {
                  context.bloc<PedidoBloc>().loadMore();
                }
              },
              padding:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 20, top: 7),
              itemCount: state.data.items.length,
              itemBuilder: (BuildContext context, int index) {
                return PedidoWidget(
                  state.data.items[index],
                  onTap: _toDetallePedido,
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  _toDetallePedido(Pedido pedido) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PedidoDetalleScreen(pedido),
      ),
    );
  }
}
