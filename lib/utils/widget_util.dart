import 'package:flutter/material.dart';

class WidgetUtils {
  static Widget borderContainer({
    Widget? child,
    Color backgroundColor = Colors.white,
    double borderRadius = 10,
    EdgeInsets padding = const EdgeInsets.all(10),
    EdgeInsets margin = const EdgeInsets.all(0),
    BoxBorder? boxBorder,
  }) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: boxBorder,
        shape: BoxShape.rectangle,
      ),
      child: child ?? const SizedBox(),
    );
  }

  static Widget noDataWidget(
    String text, {
    Color textColor = Colors.black87,
  }) {
    return Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: textColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static Widget labelTitleText({
    String title = '',
    String content = '',
    double fontSize = 12,
    Color color = Colors.black,
    FontWeight titleWeight = FontWeight.w400,
    FontWeight? contentWeight,
    Color? contentColor,
  }) {
    return RichText(
      text: TextSpan(
        text: title,
        style: TextStyle(
          fontWeight: titleWeight,
          color: color,
          fontSize: fontSize,
        ),
        children: [
          TextSpan(
            text: content,
            style: TextStyle(
              fontWeight: contentWeight ?? titleWeight,
              color: contentColor ?? color,
            ),
          )
        ],
      ),
    );
  }
}
