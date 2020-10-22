import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListShimmerWidget extends StatelessWidget {
  final EdgeInsets padding;
  final Widget Function() itemBuilder;
  final int itemCount;
  final double maxHeigth;
  final bool isGrib;
  static const double sizePadding = 12;
  ListShimmerWidget({
    this.padding = const EdgeInsets.only(bottom: sizePadding, top: sizePadding),
    this.itemBuilder,
    this.itemCount = 0,
    this.maxHeigth = 200,
    this.isGrib = false,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      for (int i = 0; i < itemCount; i++)
        (itemBuilder != null ? itemBuilder() : _defaultItem())
    ];

    if (isGrib) {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[200],
          highlightColor: Colors.grey[300],
          enabled: true,
          child: Column(
            children: children,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Container(
        padding: this.padding,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[200],
          highlightColor: Colors.grey[300],
          enabled: true,
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }

  _defaultItem() {
    if (!isGrib) {
      return Container(
        margin: const EdgeInsets.only(
            bottom: sizePadding, left: sizePadding, right: sizePadding / 2),
        height: maxHeigth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
      );
    }
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
                bottom: sizePadding, left: sizePadding, right: sizePadding / 2),
            height: maxHeigth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(
                bottom: sizePadding, left: sizePadding / 2, right: sizePadding),
            height: maxHeigth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
