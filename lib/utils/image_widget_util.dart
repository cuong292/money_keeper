import 'package:base_flutter/constant/constant_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'common_util.dart';

class ImageWidgetUtil {
  static Widget imageBorderRadius(
      double height, double width, double radius, String path) {
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: CommonUtil.fixImageUrl(path),
          width: width,
          height: height,
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/not_found.png',
            width: width,
            fit: BoxFit.contain,
            height: height,
          ),
          memCacheHeight: height.round(),
          memCacheWidth: width.round(),
        ),
      ),
    );
  }

  static Widget imageBorderRadiusSquare(
      double width, double radius, String path) {
    return imageBorderRadius(width, width, radius, path);
  }

  static Widget userAvatar(
    String imageUrl,
    double size,
    String? firstNameIfError,
    String? lastNameIfError, {
    Color color = ConstColor.colorPrimary,
    Color textColor = Colors.white,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size),
      child: CachedNetworkImage(
        imageUrl: CommonUtil.fixImageUrl(imageUrl),
        width: size,
        height: size,
        fit: BoxFit.fill,
        errorWidget: (context, url, error) => CommonUtil.noAvatarWidget(
          size.round(),
          firstNameIfError ?? '',
          lastNameIfError ?? '',
          color: color,
          textColor: textColor,
        ),
      ),
    );
  }

  static multiUserAvatar(String avatar1, String avatar2, double size) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        children: [
          Positioned(
            child: ImageWidgetUtil.userAvatar(
              avatar1,
              size * 2 / 3,
              '1',
              '',
            ),
            top: 0,
            right: 0,
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(size),
              ),
              child: ImageWidgetUtil.userAvatar(
                avatar2,
                size * 2 / 3,
                '2',
                '',
              ),
            ),
            left: 0,
            bottom: 0,
          ),
        ],
      ),
    );
  }
}
