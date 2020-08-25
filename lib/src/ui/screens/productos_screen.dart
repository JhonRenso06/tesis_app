import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> ofertas = [
      "https://cdn.pixabay.com/photo/2016/11/22/23/44/buildings-1851246_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/03/26/22/32/fast-1281628_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/24/14/00/christmas-tree-1856343_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/10/20/06/00/fiat-1754723_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/09/12/18/56/ifa-1665443_960_720.jpg"
    ];
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                      height: 200, enableInfiniteScroll: true, autoPlay: true),
                  items: ofertas.map((oferta) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height: 150,
                                  child: Image.network(
                                    oferta,
                                    fit: BoxFit.contain,
                                  )),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                  color: Colors.black,
                  height: 150,
                  width: double.maxFinite,
                  child: Image.asset(
                    "assets/logo_blanco.png",
                    fit: BoxFit.contain,
                  )))
        ],
      ),
    );
  }
}
