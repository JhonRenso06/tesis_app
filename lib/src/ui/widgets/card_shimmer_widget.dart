import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final EdgeInsets padding;

  CardShimmerWidget(
      {this.width = double.maxFinite,
      this.height,
      this.padding = const EdgeInsets.all(0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding,
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[200],
          highlightColor: Colors.grey[300],
          enabled: true,
          child: Container(
            width: this.width,
            height: this.height,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
