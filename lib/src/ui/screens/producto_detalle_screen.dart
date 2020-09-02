import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductoDetalleScreen extends StatefulWidget {
  final int codigo;
  final String nombre, foto;
  final num precio;

  ProductoDetalleScreen(this.codigo, this.nombre, this.precio, this.foto);

  @override
  State<StatefulWidget> createState() => _ProductoDetalleScreen();
}

class _ProductoDetalleScreen extends State<ProductoDetalleScreen> {
  TextEditingController cantidadController = new TextEditingController();
  MediaQueryData pantalla;
  int _current;
  initState() {
    super.initState();
    _current = 0;
  }

  @override
  Widget build(BuildContext context) {
    List<String> fotos = [];
    fotos.add(widget.foto);
    pantalla = MediaQuery.of(context);
    var width = pantalla.size.width;

    return DefaultTabController(
      length: 1,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: Color.fromRGBO(255, 87, 51, 1),
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: <Widget>[
                          Container(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                  viewportFraction: 1,
                                  height: double.maxFinite,
                                  onPageChanged: (index, _) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },
                                  enableInfiniteScroll: true,
                                  autoPlay: false),
                              items: fotos.map((oferta) {
                                return SizedBox(
                                    width: width,
                                    // height: 150,
                                    child: Image.network(
                                      oferta,
                                      fit: BoxFit.cover,
                                    ));
                              }).toList(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: width,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: fotos.map((url) {
                                    int index = fotos.indexOf(url);
                                    return Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == index
                                            ? Color.fromRGBO(255, 87, 51, 1)
                                            : Color.fromRGBO(0, 0, 0, 0.2),
                                      ),
                                    );
                                  }).toList()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: new TabBarView(children: [
                ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, _) {
                      return Stack(children: <Widget>[
                        Container(
                            width: width,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    child: Text(widget.nombre,
                                        style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),

                                Row(children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Text("S/ 4300.00",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: "Quicksand",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  255, 87, 51, 1))),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      height: 30,
                                      child: Material(
                                        color: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Color.fromRGBO(
                                                  224, 224, 224, 1),
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0)),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                  width: width / 6,
                                                  child: ButtonTheme(
                                                    buttonColor: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        50),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        50))),
                                                    child: RaisedButton(
                                                        elevation: 0,
                                                        onPressed: () {
                                                          print("Less one");
                                                        },
                                                        child: Center(
                                                            child: Icon(
                                                                Icons.remove,
                                                                textDirection:
                                                                    TextDirection
                                                                        .ltr,
                                                                color: Colors
                                                                    .black))),
                                                  )),
                                              Container(
                                                  width: width / 8,
                                                  color: Colors.white,
                                                  child: Center(
                                                    child: Text(
                                                      "0",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              "Quicksand",
                                                          fontSize: 20),
                                                    ),
                                                  )),
                                              Container(
                                                  width: width / 6,
                                                  child: ButtonTheme(
                                                    buttonColor: Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        50),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        50))),
                                                    child: RaisedButton(
                                                        elevation: 0,
                                                        onPressed: () {
                                                          print("Add one");
                                                        },
                                                        child: Center(
                                                            child: Icon(
                                                                Icons.add,
                                                                textDirection:
                                                                    TextDirection
                                                                        .rtl,
                                                                color: Colors
                                                                    .black))),
                                                  )),
                                            ]),
                                      ),
                                    ),
                                  )
                                ]),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 10, bottom: 5),
                                  child: Divider(
                                      color: Color.fromRGBO(224, 224, 224, 1)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 10, bottom: 5),
                                  child: Center(
                                    child: Container(
                                      height: 30,
                                      width: width / 2,
                                      child: Material(
                                        color: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30.0)),
                                        ),
                                        child: MaterialButton(
                                            onPressed: () {
                                              print("Añadir al carrito");
                                            },
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text("Añadir al carrito",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              "Quicksand",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)),
                                                  Icon(
                                                    Icons.shopping_cart,
                                                    color: Colors.black,
                                                    size: 15,
                                                  ),
                                                ])),
                                      ),
                                    ),
                                  ),
                                ),
                                
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 10, bottom: 5),
                                  child: Divider(
                                      color: Color.fromRGBO(224, 224, 224, 1)),
                                ),
                                
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
                                    child: Text("Descripción",
                                        style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.bold))),
                                
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 10, bottom: 5),
                                  child: Divider(
                                      color: Color.fromRGBO(224, 224, 224, 1)),
                                ),
                                
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 10, bottom: 5),
                                  child: Text(
                                    "",
                                    style: TextStyle(fontFamily: "Quicksand"),
                                  ),
                                ),
                                
                                Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, left: 10, right: 10),
                                    child: Text("Características",
                                        style: TextStyle(
                                            fontFamily: "Quicksand",
                                            fontWeight: FontWeight.bold))),
                                
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 10, bottom: 5),
                                  child: Divider(
                                      color: Color.fromRGBO(224, 224, 224, 1)),
                                ),
                                
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 10, right: 10, bottom: 5),
                                  child: Text(
                                    "",
                                    style: TextStyle(fontFamily: "Quicksand"),
                                  ),
                                ),
                              ],
                            )),
                      ]);
                      // return info();
                    }),
              ]))),
    );
  }
}
