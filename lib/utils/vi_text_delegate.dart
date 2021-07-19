import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class VietNammeseTextDelegate implements AssetsPickerTextDelegate {
  @override
  String cancel = 'Huỷ';

  @override
  String confirm = 'Xác nhận';

  @override
  String edit = 'Sửa';

  @override
  String gifIndicator = 'GIF';

  @override
  String heicNotSupported = 'Unsupported HEIC asset type.';

  @override
  String loadFailed = 'Chọn tệp không thành công';

  @override
  String original = 'Original';

  @override
  String preview = 'Xem trước';

  @override
  String select = 'Chọn';

  @override
  String unSupportedAssetType = 'Không hỗ trợ tệp này';

  @override
  String durationIndicatorBuilder(Duration duration) {
    return AssetsPickerTextDelegate.defaultDurationIndicatorBuilder(duration);
  }
}
