import 'package:base_flutter/base/data/api/app_api.dart';

extension StringExt on String {
  String removeAccent() {
    var str = this;
    var withDia =
        'ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚÝàáâãèéêìíòóôõùúýĂăĐđĨĩŨũƠơƯưẠạẢảẤấẦầẨẩẪẫẬậẮắẰằẲẳẴẵẶặẸẹẺẻẼẽẾếỀềỂểỄễỆệỈỉỊịỌọỎỏỐốỒồỔổỖỗỘộỚớỜờỞởỠỡỢợỤụỦủỨứỪừỬửỮữỰự';
    var withoutDia =
        'AAAAEEEIIOOOOUUYaaaaeeeiioooouuyAaDdIiUuOoUuAaAaAaAaAaAaAaAaAaAaAaAaEeEeEeEeEeEeEeEeIiIiOoOoOoOoOoOoOoOoOoOoOoOoUuUuUuUuUuUuUu';

    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }

    return str;
  }

  bool containsWith(String anotherText, {bool withoutAccent = true}) {
    if (withoutAccent) {
      return this
          .toLowerCase()
          .removeAccent()
          .contains(anotherText.toLowerCase().removeAccent());
    }
    return this.toLowerCase().contains(anotherText.toLowerCase());
  }
}

extension StringNullExt on String? {
  String imageFormatted() {
    if (this?.isEmpty == true) return '';
    if (this?.startsWith('http') == true) return this ?? '';
    return AppApi.BASE_URL + (this?.substring(1) ?? '');
  }
}
