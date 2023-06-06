 import 'package:dio/dio.dart';

import 'interceptor/token_interceptor.dart';

class DioSingleton {
  static final DioSingleton _singleton = DioSingleton._internal();
  late Dio _dio;

  factory DioSingleton() {
    return _singleton;
  }

  DioSingleton._internal() {
    _dio = Dio();
    _dio.options.baseUrl = 'https://api.example.com';
    _dio.options.connectTimeout = 60000;
    _dio.options.receiveTimeout = 60000;
    _dio.interceptors.add(TokenInterceptor());
    // Add other configuration options here
  }

  Dio get dio {
    return _dio;
  }
}
