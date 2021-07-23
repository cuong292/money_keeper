import 'package:base_flutter/constant/constant_color.dart';
import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  bool checked;

  ValueChanged<bool> onCheckChange;

  double size;

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();

  CustomCheckBox(this.checked, this.onCheckChange, {this.size = 18});
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(
          () {
            widget.checked = !widget.checked;
            widget.onCheckChange(widget.checked);
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: widget.checked
              ? Border.all(
                  color: ConstColor.colorPrimary,
                  width: 1,
                )
              : Border.all(
                  color: ConstColor.gray7E7,
                  width: 1,
                ),
          borderRadius: BorderRadius.circular(8),
          color: widget.checked ? ConstColor.colorPrimary : Colors.white,
        ),
        child: widget.checked
            ? Icon(
                Icons.check,
                size: widget.size,
                color: Colors.white,
              )
            : Icon(
                null,
                size: widget.size,
              ),
      ),
    );
  }

  _CustomCheckBoxState();
}
