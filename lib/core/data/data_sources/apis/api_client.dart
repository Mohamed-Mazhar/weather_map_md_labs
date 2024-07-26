import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_map_md_labs/core/data/data_sources/apis/api_list.dart';
import 'package:weather_map_md_labs/core/data/data_sources/apis/error_interceptor.dart';
import 'package:weather_map_md_labs/core/data/data_sources/exceptions/weather_exception.dart';

class ApiClient {
  static ApiClient? _instance;
  final _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 60),
    ),
  );

  ApiClient._() {
    _dio.interceptors.add(ErrorInterceptor());
  }

  factory ApiClient.instance() {
    return _instance ??= ApiClient._();
  }

  Future<dynamic> getRequest({
    required String endPoint,
    Map<String, dynamic> parameters = const {},
    String pathVariables = "",
  }) async {
    try {
      final Map<String, dynamic> body = {"appid": ApiList.apiKey};
      body.addAll(parameters);
      debugPrint("$endPoint - Request - Parameters: $body");
      final response = await _dio.get(endPoint, queryParameters: body);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw WeatherException(title: 'Unknown error', message: 'Failed to retrieve data');
      }
    } on DioException catch (e) {
      if (e.error is WeatherException) {
        throw e.error as WeatherException;
      } else {
        throw WeatherException(title: 'Unknown error', message: 'PLease try again later');
      }
    }
  }

  Future<dynamic> postRequest({
    required String endPoint,
    Map<String, dynamic> parameters = const {},
  }) async {
    try {
      final response = await _dio.post(endPoint, data: parameters);
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }
}
