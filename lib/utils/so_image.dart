import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class SchoolOnlineImage {
  String? url;
  AssetEntity? localImage;
  String? path;

  SchoolOnlineImage.network(this.url);

  SchoolOnlineImage.local(this.localImage);

  SchoolOnlineImage.localFromPath(this.path);

  ImageType getType() {
    return url == null ? ImageType.LOCAL : ImageType.NETWORK;
  }
}

enum ImageType { LOCAL, NETWORK }
