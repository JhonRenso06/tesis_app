import 'package:flutter/material.dart';
import 'package:tesis_app/src/ui/screens/carrito_screen.dart';
import 'package:tesis_app/src/ui/screens/categorias_screen.dart';
import 'package:tesis_app/src/ui/screens/pedidos_screen.dart';
import 'package:tesis_app/src/ui/screens/perfil_screen.dart';
import 'package:tesis_app/src/ui/screens/productos_screen.dart';

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
                  // backgroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Color.fromRGBO(255, 87, 51, 1),
                  title: new Text("INVERSIONES J&R IMPORT E.I.R.L",
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold)),
                  centerTitle: true,
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: new TabBar(
                    tabs: <Tab>[
                      new Tab(icon: Icon(Icons.directions_car)),
                      new Tab(icon: Icon(Icons.category)),
                      new Tab(icon: Icon(Icons.shopping_cart)),
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
