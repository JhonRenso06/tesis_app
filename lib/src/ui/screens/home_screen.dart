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
                  backgroundColor: Color.fromRGBO(77, 17, 48, 1),
                  title: new Text("J&R Store",
                      style: TextStyle(
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold)),
                  centerTitle: true,
                  pinned: true,
                  floating: true,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search), 
                      onPressed: (){

                      }
                    )
                  ],
                  forceElevated: innerBoxIsScrolled,
                  bottom: new TabBar(
                    labelStyle:
                        TextStyle(fontSize: 12, fontFamily: "Quicksand"),
                    tabs: <Tab>[
                      new Tab(icon: Icon(Icons.directions_car)),
                      new Tab(icon: Icon(Icons.category)),
                      new Tab(
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Icon(Icons.shopping_cart, size: 25),
                            if (1 > 0)
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, bottom: 10),
                                child: CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  child: Text(
                                    "2",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
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
