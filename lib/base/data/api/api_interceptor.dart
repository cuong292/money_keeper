import 'package:base_flutter/base/data/storage/sp_utils.dart';
import 'package:base_flutter/base/navigation_service.dart';
import 'package:base_flutter/constant/constant_value.dart';
import 'package:base_flutter/generated/l10n.dart';
import 'package:dio/dio.dart';

import '../../service_locator.dart';

class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO: implement onRequest
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    // TODO: implement onError
    if (err.response != null && err.response!.statusCode == 401) {
      var util = await SharePreferenceRepository.instance;
      await util.remove(KEY_AUTHORIZATION_TOKEN);
      locator<NavigationService>().onTokenExpire();
      var saveData = util.getBool(KEY_REMEMBER_ACCOUNT) ?? false;
      if (!saveData) {
        util.remove(KEY_USER_NAME);
        util.remove(KEY_PASSWORD);
        util.remove(KEY_SCHOOL_CODE);
      }
      return;
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // TODO: implement onResponse
    if (response.data != null && response.data['status'] == 112) {
      var util = await SharePreferenceRepository.instance;
      await util.remove(KEY_AUTHORIZATION_TOKEN);
      locator<NavigationService>().onTokenExpire();
      var saveData = util.getBool(KEY_REMEMBER_ACCOUNT) ?? false;
      if (!saveData) {
        util.remove(KEY_USER_NAME);
        util.remove(KEY_PASSWORD);
        util.remove(KEY_SCHOOL_CODE);
      }
      response.data['data'] = null;
      response.data['message'] = S().token_expired;
      return super.onResponse(response, handler);
    }

    if (response.data == null ||
        (response.data != null && response.data['status'] != 1)) {
      response.data['data'] = null;
    }
    return super.onResponse(response, handler);
  }
}
