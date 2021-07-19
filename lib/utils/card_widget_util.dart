import 'package:base_flutter/constant/constant_widget.dart';
import 'package:flutter/material.dart';

class CardWidgetUtil {
  static Card defaultCard(
      {Widget child = emptyView,
      double borderRadius = 4,
      Color color = Colors.white,
      bool border = false,
      Color borderColor = Colors.black,
      double borderWidth = 1,
      EdgeInsetsGeometry margin = const EdgeInsets.all(0)}) {
    return Card(
      color: color,
      margin: margin,
      child: child,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: border
            ? BorderSide(
                color: borderColor,
                width: borderWidth,
              )
            : BorderSide.none,
      ),
    );
  }
}
