import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static CupertinoAlertDialog yesNoDialog(
    BuildContext context,
    String title,
    String message,
    VoidCallback yesClick, {
    String yesMessage = 'Yes',
    String noMessage = 'No',
    Color yesTextColor = Colors.black,
    Color noTextColor = Colors.black,
  }) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          child: Text(
            yesMessage,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: yesTextColor,
            ),
          ),
          onPressed: yesClick,
          isDefaultAction: true,
        ),
        CupertinoDialogAction(
          child: Text(
            noMessage,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: noTextColor,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  static CupertinoAlertDialog yesNoDialogCustomContent(
    BuildContext context,
    String title,
    Widget message,
    VoidCallback yesClick, {
    String yesMessage = 'Yes',
    String noMessage = 'No',
    Color yesTextColor = Colors.black,
    Color noTextColor = Colors.black,
  }) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: message,
      actions: [
        CupertinoDialogAction(
          child: Text(
            yesMessage,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: yesTextColor,
            ),
          ),
          onPressed: yesClick,
          isDefaultAction: true,
        ),
        CupertinoDialogAction(
          child: Text(
            noMessage,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: noTextColor,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  static void animationShowDialog(BuildContext context,
      {required Widget child}) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 250),
      barrierDismissible: true,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, a1, a2) => SizedBox.shrink(),
      transitionBuilder: (context, a1, a2, widget) => Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: child,
        ),
      ),
    );
  }
}
