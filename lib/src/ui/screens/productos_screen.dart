import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tesis_app/src/ui/widgets/producto_widget.dart';

class ProductosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> ofertas = [
      "https://png.pngtree.com/png-vector/20190411/ourlarge/pngtree-job-vacancy-flat-design-concept-png-image_926058.jpg",
      "https://png.pngtree.com/png-vector/20190821/ourlarge/pngtree-sale-discount-offer-banner-promotion-special-offer-price-vector-illustration-png-image_1693312.jpg",
      "https://png.pngtree.com/element_our/md/20180302/md_5a98f93a2fafc.jpg",
      "https://www.seekpng.com/png/detail/238-2388746_oferta-semana-de-ofertas-png.png",
      "https://png.pngtree.com/element_our/png_detail/20181130/flash-sale-banner-template-special-offer-with-thunder-png_253955.jpg"
    ];
    List<String> productos = [
      "https://cdn.pixabay.com/photo/2016/03/26/22/32/fast-1281628_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/24/14/00/christmas-tree-1856343_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/10/20/06/00/fiat-1754723_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/09/12/18/56/ifa-1665443_960_720.jpg"
    ];
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 1) / 2;
    final double itemWidth = size.width / 2;

    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: CarouselSlider(
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
                              width: 400,
                              height: 200,
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
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                  color: Colors.black,
                  height: 150,
                  width: double.maxFinite,
                  child: Image.asset(
                    "assets/logo_blanco.png",
                    fit: BoxFit.contain,
                  ))),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: itemHeight,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: (itemWidth / (itemHeight / 1.4))),
          delegate: SliverChildBuilderDelegate((context, int index) {
            return ProductoWidget(
                index,
                "Organizador Nevera Multifuncional Para Auto $index",
                index,
                productos[index]);
          }, childCount: productos.length),
        )
      ],
    );
  }
}
