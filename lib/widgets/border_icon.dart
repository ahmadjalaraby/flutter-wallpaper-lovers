import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

class BorderIcon extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double? width, height;

  const BorderIcon(
      {Key? key,
      required this.child,
      required this.padding,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: DynamicTheme.of(context)!.themeId == 2
                                      ? Colors.grey[800]
                                    : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            border:
                Border.all(color: Colors.grey[400]!.withAlpha(40), width: 2)),
        padding: padding,
        child: Center(child: child));
  }
}
