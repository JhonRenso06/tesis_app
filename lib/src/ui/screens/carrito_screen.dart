import 'package:flutter/material.dart';
import 'package:tesis_app/src/ui/widgets/item_widget.dart';

class CarritoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ItemWidget(), ItemWidget(), ItemWidget()],
        ),
      ),
    ));
  }
}
