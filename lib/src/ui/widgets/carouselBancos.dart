import 'package:carousel_slider/carousel_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarouselBancos extends StatefulWidget {
  @override
  _CarouselBancosState createState() => _CarouselBancosState();
}

class _CarouselBancosState extends State<CarouselBancos> {
  int _current;
  @override
  void initState() {
    _current = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            child: CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300,
                autoPlay: true,
                onPageChanged: (index, _) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              items: [
                monederoData(
                  "assets/yape.png",
                  "+51 956 679 250",
                  "Mayra Velasquez Tello",
                ),
                monederoData(
                  "assets/plin.png",
                  "+51 960 410 414",
                  "Freddy Yupanqui Calderon",
                  two: "assets/lukita.jpg",
                  radius: 0,
                ),
                bancoData(
                  "assets/bcp.png",
                  "BCP",
                  "Velasquez Tello Mayra Stephany",
                  "57091652258091",
                  "00257019165225809105",
                ),
                bancoData(
                  "assets/bbva.png",
                  "BBVA",
                  "Freddy Yupanqui",
                  "57091652258091",
                  "01124900020205749105",
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [0, 1, 2, 3].map((index) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 2.0,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(77, 17, 48, 1)
                      : Color.fromRGBO(0, 0, 0, 0.2),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget bancoData(
      String imagen, String banco, String titular, String cuenta, String cci) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Image.asset(
                  imagen,
                  height: 100,
                  width: 100,
                ),
              ),
              Text(
                banco,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                titular,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.maxFinite,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    FlutterClipboard.copy(cuenta).then(
                      (value) {
                        Fluttertoast.showToast(
                          msg: "Número de cuenta copiada",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cuenta",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cuenta,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.maxFinite,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    FlutterClipboard.copy(cci).then(
                      (value) {
                        Fluttertoast.showToast(
                          msg: "Número CCI copiado",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "CCI",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          cci,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget monederoData(String imagen, String numero, String titular,
      {double radius = 24, String two}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              if (two != null)
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            image: DecorationImage(
                              image: AssetImage(imagen),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            image: DecorationImage(
                              image: AssetImage(two),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              else
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      image: DecorationImage(
                        image: AssetImage(imagen),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 24,
              ),
              Text(
                titular,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.maxFinite,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    FlutterClipboard.copy(numero).then(
                      (value) {
                        Fluttertoast.showToast(
                          msg: "Número copiado",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Número",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          numero,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
