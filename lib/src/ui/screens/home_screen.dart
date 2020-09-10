import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/src/providers/carrito_provider.dart';
import 'package:tesis_app/src/ui/screens/carrito_screen.dart';
import 'package:tesis_app/src/ui/screens/categorias_screen.dart';
import 'package:tesis_app/src/ui/screens/pedidos_screen.dart';
import 'package:tesis_app/src/ui/screens/perfil_screen.dart';
import 'package:tesis_app/src/ui/screens/productos_screen.dart';
import 'package:tesis_app/src/ui/widgets/cantidad_carrito_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 5, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var carritoProvider = Provider.of<CarritoProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: new NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  backgroundColor: Color.fromRGBO(77, 17, 48, 1),
                  title: new Text("J&R Store",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold)),
                  centerTitle: true,
                  pinned: true,
                  floating: true,
                  actions: <Widget>[
                    IconButton(icon: Icon(Icons.search), onPressed: () {})
                  ],
                  forceElevated: innerBoxIsScrolled,
                  bottom: new TabBar(
                    labelStyle:
                        TextStyle(fontSize: 12, fontFamily: "Quicksand"),
                    tabs: <Tab>[
                      new Tab(icon: Icon(Icons.directions_car)),
                      new Tab(icon: Icon(Icons.category)),
                      new Tab(
                          child:
                              CantidadCarritoWidget(carritoProvider.cantidad)),
                      new Tab(icon: Icon(Icons.library_books)),
                      new Tab(icon: Icon(Icons.person))
                    ],
                    controller: _tabController,
                  ),
                ),
              ];
            },
            body: new TabBarView(
              children: <Widget>[
                ProductosScreen(),
                CategoriasScreen(),
                CarritoScreen(),
                PedidosScreen(),
                PerfilScreen()
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }
}
