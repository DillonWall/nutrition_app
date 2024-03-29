import 'package:flutter/material.dart';

typedef VerticalCarouselBoxColorCallback<T> = Color Function(
  BuildContext context,
  List<T> items,
  int index,
);
typedef VerticalCarouselBoxChildrenCallback<T> = List<Widget> Function(
  BuildContext context,
  List<T> items,
  int index,
);
typedef VerticalCarouselBoxShadowCallback<T> = List<BoxShadow>? Function(
  BuildContext context,
  List<T> items,
  int index,
);

class VerticalCarousel<T> extends StatelessWidget {
  final BuildContext context;
  final List<T> items;
  final double itemHeight;
  final double separationHeight;
  final VerticalCarouselBoxColorCallback<T> boxColorCallback;
  final VerticalCarouselBoxChildrenCallback<T> boxChildrenCallback;
  final VerticalCarouselBoxShadowCallback<T> boxShadowCallback;
  final MainAxisAlignment itemMainAxisAlignment;
  final EdgeInsetsGeometry itemPadding;
  final BorderRadiusGeometry itemBorderRadius;
  final EdgeInsetsGeometry padding;
  final double? height;
  final bool shrinkWrap;

  const VerticalCarousel({
    super.key,
    required this.context,
    required this.items,
    required this.itemHeight,
    required this.separationHeight,
    required this.boxColorCallback,
    required this.boxChildrenCallback,
    required this.boxShadowCallback,
    this.itemMainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.itemPadding = EdgeInsets.zero,
    this.itemBorderRadius = const BorderRadius.all(Radius.circular(16)),
    this.padding = const EdgeInsets.all(20),
    this.shrinkWrap = true,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    var listView = ListView.separated(
      itemCount: items.length,
      scrollDirection: Axis.vertical,
      padding: padding,
      shrinkWrap: height == null ? true : shrinkWrap,
      separatorBuilder: (context, index) => SizedBox(width: separationHeight),
      itemBuilder: (context, index) {
        return Container(
          width: itemHeight,
          decoration: BoxDecoration(
            color: boxColorCallback(context, items, index),
            borderRadius: itemBorderRadius,
            boxShadow: boxShadowCallback(context, items, index),
          ),
          child: Padding(
            padding: itemPadding,
            child: Row(
              mainAxisAlignment: itemMainAxisAlignment,
              children: boxChildrenCallback(context, items, index),
            ),
          ),
        );
      },
    );

    if (height != null) {
      return SizedBox(
        height: height,
        child: listView,
      );
    }
    return listView;
  }
}
