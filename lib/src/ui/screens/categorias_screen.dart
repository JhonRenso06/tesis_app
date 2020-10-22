import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mr_yupi/src/bloc/categoria_bloc.dart';
import 'package:mr_yupi/src/bloc/productos_categoria_bloc.dart';
import 'package:mr_yupi/src/model/api_response.dart';
import 'package:mr_yupi/src/model/categoria.dart';
import 'package:mr_yupi/src/ui/screens/productos_categoria_screen.dart';
import 'package:mr_yupi/src/ui/widgets/categoria_widget.dart';
import 'package:mr_yupi/src/ui/widgets/list_shimmer_widget.dart';
import 'package:mr_yupi/src/ui/widgets/load_more_list.dart';

class CategoriasScreen extends StatefulWidget {
  @override
  _CategoriasScreenState createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  @override
  void initState() {
    context.bloc<CategoriaBloc>().initialLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriaBloc, APIResponse<Paginate<Categoria>>>(
      cubit: context.bloc<CategoriaBloc>(),
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
              context.bloc<CategoriaBloc>().loadMore();
            },
            padding: const EdgeInsets.all(6),
            itemCount: state.data.items.length,
            itemBuilder: (BuildContext context, int index) {
              return CategoriaWidget(
                state.data.items[index],
                onTap: _onTap,
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  _onTap(Categoria categoria) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductosPorCategoriaScreen(categoria),
    ));
  }
}
