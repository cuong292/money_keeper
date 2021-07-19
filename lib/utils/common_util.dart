import 'dart:io';

import 'package:base_flutter/base/data/api/app_api.dart';
import 'package:base_flutter/base/navigation_service.dart';
import 'package:base_flutter/base/service_locator.dart';
import 'package:base_flutter/constant/constant_color.dart';
import 'package:base_flutter/generated/l10n.dart';
import 'package:base_flutter/screen/image_view_widget.dart';
import 'package:base_flutter/utils/so_image.dart';
import 'package:base_flutter/utils/vi_text_delegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CommonUtil {
  static const _vietnamese = 'aAeEoOuUiIdDyY';

  static final _vietnameseRegex = <RegExp>[
    RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
    RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
    RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
    RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
    RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
    RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
    RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
    RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
    RegExp(r'ì|í|ị|ỉ|ĩ'),
    RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
    RegExp(r'đ'),
    RegExp(r'Đ'),
    RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
    RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
  ];

  static String parseHtmlToText(String html) {
    dom.Element? element = parser.parse(html).documentElement;
    if (element != null) {
      return element.text;
    }
    return '';
  }

  static fixImageUrl(String? avatar) {
    if (avatar == null) return null;
    if (Uri.parse(avatar).isAbsolute) {
      return avatar;
    }
    if (avatar.startsWith('/')) {
      avatar = avatar.substring(1);
    }
    return AppApi.BASE_URL + avatar;
  }

  static String getShortName(String lastname, String firstname) {
    if (lastname.isEmpty && firstname.isEmpty) {
      return '00';
    } else if (lastname.isEmpty) {
      if (firstname.length < 2) {
        return firstname;
      } else {
        return firstname.substring(0, 2);
      }
    } else if (firstname.isEmpty) {
      if (lastname.length < 2) {
        return lastname;
      } else {
        return lastname.substring(0, 2);
      }
    } else {
      return firstname[0] + lastname[0];
    }
  }

  static Widget noAvatarWidget(
    int size,
    String firstName,
    String lastName, {
    Color color = ConstColor.colorPrimary,
    Color textColor = Colors.white,
  }) {
    String shortName = getShortName(lastName, firstName).trim();
    return Container(
        width: size.toDouble(),
        height: size.toDouble(),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        alignment: Alignment.center,
        child: Text(shortName.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: (size / 3).round().toDouble(),
            )));
  }

  static Color colorFromHex(String hexColor) {
    try {
      final hexCode = hexColor.replaceAll('#', '');
      return Color(int.parse('FF$hexCode', radix: 16));
    } on Exception catch (e) {
      return ConstColor.colorPrimary;
    }
  }

  static String formatCurrency(int number, {String symbol = ''}) {
    return NumberFormat.currency(symbol: symbol, name: '', decimalDigits: 0)
        .format(number);
  }

  static Future<List<AssetEntity>?> pickImages(BuildContext context,
      {int maxImage = 1}) async {
    if (Platform.isIOS) {
      await Permission.photos.request();
    } else {
      await Permission.storage.request();
    }

    var status = await (Platform.isIOS
        ? Permission.photos.status
        : Permission.storage.status);
    if (status.isDenied || status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(S.of(context).image_permission_title),
          content: Text(S.of(context).image_permission_body),
          actions: [
            CupertinoDialogAction(
              child: Text(S().cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text(S().setting),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return Future.value(null);
    } else {
      return AssetPicker.pickAssets(
        context,
        maxAssets: maxImage,
        themeColor: ConstColor.colorPrimary,
        textDelegate: Intl.getCurrentLocale() == 'vi'
            ? VietNammeseTextDelegate()
            : EnglishTextDelegate(),
        requestType: RequestType.image,
      );
    }
  }

  static String removeAccent(String str) {
    for (int i = 0; i < _vietnameseRegex.length; i++) {
      str = str.replaceAll(_vietnameseRegex[i], _vietnamese[i]);
    }
    return str;
  }

  static void showFullScreenImages({
    List<AssetEntity> assets = const [],
    List<String> imageUrl = const [],
    List<String> path = const [],
  }) {
    List<SchoolOnlineImage> images = [];
    assets.forEach((element) {
      images.add(SchoolOnlineImage.local(element));
    });

    imageUrl.forEach((element) {
      images.add(SchoolOnlineImage.network(element));
    });

    path.forEach((element) {
      images.add(SchoolOnlineImage.localFromPath(element));
    });

    locator<NavigationService>().navigateRoute(
      CupertinoPageRoute(
        builder: (context) => ImageViewerWidget(
          images,
        ),
      ),
    );
  }
}
