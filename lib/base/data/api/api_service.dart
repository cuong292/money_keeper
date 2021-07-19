import 'package:base_flutter/constant/constant_value.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) {
    return _ApiService(dio, baseUrl: BASE_URL);
  }
}
