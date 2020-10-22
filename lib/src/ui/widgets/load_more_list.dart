import 'package:flutter/material.dart';

class LoadMoreList extends StatefulWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final EdgeInsets padding;
  final int itemCount;
  final Function onMaxScroll;
  final bool loading;
  LoadMoreList({
    this.itemBuilder,
    this.padding = const EdgeInsets.all(0),
    this.itemCount,
    this.onMaxScroll,
    this.loading = false,
  });

  @override
  _LoadMoreListState createState() => _LoadMoreListState();
}

class _LoadMoreListState extends State<LoadMoreList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels >=
                (scrollInfo.metrics.maxScrollExtent - 200) &&
            !widget.loading) {
          if (widget.onMaxScroll != null) {
            widget.onMaxScroll();
          }
        }
        return true;
      },
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemBuilder: (context, index) {
          if (index == widget.itemCount) {
            return Container(
              height: 70,
              width: double.maxFinite,
              child: Center(
                child: !widget.loading
                    ? Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      )
                    : Container(
                        height: 17,
                        width: 17,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                        ),
                      ),
              ),
            );
          } else {
            return widget.itemBuilder(context, index);
          }
        },
        itemCount: widget.itemCount + 1,
      ),
    );
  }
}
