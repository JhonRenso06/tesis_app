import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageCardWidget extends StatelessWidget {
  final double width, height;
  final Widget child;
  final String imageUrl;
  final Function onTap;
  final double elevation;
  final EdgeInsets margin;
  final double radius;
  final BoxFit fit;

  ImageCardWidget({
    this.width = double.maxFinite,
    this.height = double.maxFinite,
    this.child,
    this.imageUrl,
    this.onTap,
    this.elevation = 0,
    this.margin = const EdgeInsets.all(6),
    this.radius = 12,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: this.margin,
      elevation: this.elevation,
      semanticContainer: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: SizedBox(
        width: this.width,
        height: this.height,
        child: (this.imageUrl != null && this.imageUrl.isNotEmpty)
            ? CachedNetworkImage(
                width: double.maxFinite,
                height: double.maxFinite,
                imageUrl: this.imageUrl,
                placeholder: (context, _) => Shimmer.fromColors(
                  baseColor: Colors.grey[200],
                  highlightColor: Colors.grey[300],
                  enabled: true,
                  child: Container(
                    color: Colors.white,
                  ),
                ),
                errorWidget: (_, __, r) {
                  return Container(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          splashColor: Colors.black12,
                          onTap: this.onTap,
                          child: this.child),
                    ),
                    decoration: BoxDecoration(color: Colors.white),
                  );
                },
                imageBuilder: (context, imageProvider) => Container(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        splashColor: Colors.black12,
                        onTap: this.onTap,
                        child: this.child),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: this.fit,
                    ),
                  ),
                ),
              )
            : Container(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      splashColor: Colors.black12,
                      onTap: this.onTap,
                      child: this.child),
                ),
                decoration: BoxDecoration(color: Colors.white),
              ),
      ),
    );
  }
}
