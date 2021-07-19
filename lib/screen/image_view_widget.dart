import 'dart:io';

import 'package:base_flutter/constant/constant_color.dart';
import 'package:base_flutter/constant/constant_widget.dart';
import 'package:base_flutter/generated/l10n.dart';
import 'package:base_flutter/utils/so_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImageViewerWidget extends StatefulWidget {
  final List<SchoolOnlineImage> images;

  @override
  _ImageViewerWidgetState createState() => _ImageViewerWidgetState();

  ImageViewerWidget(this.images);
}

class _ImageViewerWidgetState extends State<ImageViewerWidget> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        widget.images.forEach(
          (imageUrl) {
            if (imageUrl.getType() == ImageType.NETWORK)
              precacheImage(NetworkImage(imageUrl.url ?? ''), context);
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    S().done,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ConstColor.colorPrimary,
                    ),
                  ),
                ),
              ),
            ),
            line2View,
            Expanded(
              child: CarouselSlider.builder(
                itemCount: widget.images.length,
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    disableCenter: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height),
                itemBuilder: (context, index, realIdx) {
                  final item = widget.images[index];
                  return Container(
                    color: Colors.white70,
                    child: widget.images[index].getType() == ImageType.NETWORK
                        ? CachedNetworkImage(
                            imageUrl: item.url!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.fitWidth,
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/image/not_found.png'),
                          )
                        : _buildLocalImage(item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocalImage(SchoolOnlineImage item) {
    final assetImage = item.localImage;
    if (assetImage != null)
      return Image(
        image: AssetEntityImageProvider(assetImage, isOriginal: false),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.fitWidth,
      );
    final pathImage = item.path;
    if (pathImage == null) return emptyView;
    return Image(
      image: FileImage(File(pathImage)),
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fitWidth,
    );
  }
}
