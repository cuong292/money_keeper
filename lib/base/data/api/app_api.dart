import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:base_flutter/base/data/storage/sp_utils.dart';
import 'package:base_flutter/constant/constant_value.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'api_interceptor.dart';
import 'api_service.dart';

class AppApi {
  static var BASE_URL = '';

  static final Dio dio = Dio()
    ..options = BaseOptions(
        baseUrl: BASE_URL, connectTimeout: 30000, receiveTimeout: 6000)
    ..interceptors.add(AuthInterceptor())
    ..interceptors.add(ApiInterceptor())
    ..interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
      request: true,
      requestHeader: true,
      error: true,
    ));

  static var logger = Logger(
    printer: PrettyPrinter(),
  );

  static ApiService? apiService;

  static ApiService getApiService() {
    apiService ??= ApiService(dio);
    return apiService!;
  }

  static void reConfigService() {
    apiService = null;
  }
}

class AuthInterceptor extends Interceptor {
  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var sp = await SharePreferenceRepository.instance;
    final token = sp.get(KEY_AUTHORIZATION_TOKEN);
    final studentId = sp.getInt(KEY_SELECTED_STUDENT_ID);
    final lang = Intl.defaultLocale;
    var deviceId = await sp.get(KEY_DEVICE_TOKEN);
    options.headers.putIfAbsent('device-type', () => Platform.isIOS ? 1 : 0);
    options.headers.putIfAbsent('device-id', () => deviceId);
    if (studentId != null) {
      options.headers.update(
        'student-id',
        (value) => studentId,
        ifAbsent: () => studentId,
      );
    }
    if (token != null) {
      options.headers.update('Authorization', (_) => 'Bearer' + token,
          ifAbsent: () => 'Bearer' + token);
    }
    options.headers.update('lang', (_) => lang, ifAbsent: () => lang);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }
}

class ChatHeaderInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // TODO: implement onRequest
    var sp = await SharePreferenceRepository.instance;
    String? token = sp.getString(KEY_CHAT_TOKEN);
    if (token != null) {
      options.headers.update("Authorization", (_) => "Bearer " + token,
          ifAbsent: () => "Bearer " + token);
    }
    inspect(jsonEncode(options.data));
    super.onRequest(options, handler);
  }
}
