import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tesis_app/src/model/producto.dart';
import 'package:tesis_app/src/ui/widgets/caracteristicas_widget.dart';

class ProductoDetalleScreen extends StatefulWidget {
  final Producto producto;

  ProductoDetalleScreen(this.producto);

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
                    leading: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),  
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    actions: [
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                          icon: Icon(Icons.shopping_cart), 
                          onPressed: (){

                          }
                        ),
                      )
                    ],
                    backgroundColor: Color.fromRGBO(77, 17, 48, 1),
                    expandedHeight: MediaQuery.of(context).size.width * 0.9,
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
                              items: widget.producto.fotos.map((foto) {
                                return SizedBox(
                                  width: width,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: foto,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: width,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: widget.producto.fotos.map((foto) {
                                    int index =
                                        widget.producto.fotos.indexOf(foto);
                                    return Container(
                                      width: 8.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _current == index
                                            ? Color.fromRGBO(77, 17, 48, 1)
                                            : Color.fromRGBO(0, 0, 0, 0.2),
                                      ),
                                    );
                                  }).toList()),
                            ),
                          ),
                          Container(
                            height: kToolbarHeight + MediaQuery.of(context).padding.top,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [ Colors.black87, Colors.transparent],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter
                                  )
                                ),
                              )
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
                                    child: Text(widget.producto.nombre,
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
                                      child: widget.producto.descuento !=
                                                  null &&
                                              widget.producto.descuento > 0
                                          ? Column(children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                      "S/" +
                                                          widget.producto
                                                              .precioToFixed,
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          fontFamily:
                                                              "Quicksand",
                                                          fontSize: 15,
                                                          color: Colors.grey)),
                                                  Text(
                                                      " " +
                                                          widget.producto
                                                              .porcentajeDescuento,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Quicksand",
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                ],
                                              ),
                                              Text(
                                                  "S/" +
                                                      widget.producto
                                                          .precioDescuentoToFixed,
                                                  style: TextStyle(
                                                      fontFamily: "Quicksand",
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          77, 17, 48, 1))),
                                            ])
                                          : Text(
                                              "S/" +
                                                  widget.producto.precioToFixed,
                                              style: TextStyle(
                                                  fontFamily: "Quicksand",
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
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
                                widget.producto.descripcion != null
                                    ? Column(children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 10, right: 10),
                                            child: Text("Descripción",
                                                style: TextStyle(
                                                    fontFamily: "Quicksand",
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5,
                                              left: 10,
                                              right: 10,
                                              bottom: 5),
                                          child: Divider(
                                              color: Color.fromRGBO(
                                                  224, 224, 224, 1)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5,
                                              left: 10,
                                              right: 10,
                                              bottom: 5),
                                          child: Text(
                                            widget.producto.descripcion,
                                            style: TextStyle(
                                                fontFamily: "Quicksand"),
                                          ),
                                        ),
                                      ])
                                    : SizedBox.shrink(),
                                widget.producto.caracteristicas != null
                                    ? Column(children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 10, right: 10),
                                            child: Text("Características",
                                                style: TextStyle(
                                                    fontFamily: "Quicksand",
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5,
                                              left: 10,
                                              right: 10,
                                              bottom: 5),
                                          child: Divider(
                                              color: Color.fromRGBO(
                                                  224, 224, 224, 1)),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                left: 10,
                                                right: 10,
                                                bottom: 5),
                                            child: CaracteristicasWidget(widget
                                                .producto.caracteristicas)),
                                      ])
                                    : SizedBox.shrink()
                              ],
                            )),
                      ]);
                      // return info();
                    }),
              ]))),
    );
  }
}
