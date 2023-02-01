import 'package:dio/dio.dart';

class DioClient {
  String baseUrl = 'https://gorest.co.in/public/v2';
  static const _appTokenEnvironmentVariableKey = 'gorest-app-token';
  final appToken =
      const String.fromEnvironment(_appTokenEnvironmentVariableKey);

  late Dio _dio;

  DioClient() {
    _dio = _createDio();
  }

  Dio get dio {
    final dio = _createDio();
    return dio;
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': appToken,
          },
          receiveTimeout: 60000,
          connectTimeout: 60000,
          validateStatus: (int? status) {
            return status! > 0;
          },
        ),
      );

  Future<Response> getRequest(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return dio.get(url, queryParameters: queryParameters);
    } on DioError catch (e) {
      throw Exception(
        e.message,
      );
    }
  }

  Future<Response> postRequest(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    try {
      return await dio.post(url, data: data);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> putRequest(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    try {
      return await dio.put(url, data: data);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> deleteRequest(String url) async {
    try {
      await dio.delete(url);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}
