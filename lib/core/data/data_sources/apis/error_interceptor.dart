import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_map_md_labs/core/data/data_sources/exceptions/weather_exception.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    WeatherException weatherException;

    if (err.type == DioExceptionType.connectionTimeout) {
      weatherException = WeatherException(
        title: err.response?.statusCode.toString() ?? '',
        message: "Connection Timeout",
      );
    } else if (err.type == DioExceptionType.sendTimeout) {
      weatherException = WeatherException(
        message: "Send Timeout",
        title: err.response?.statusCode.toString() ?? "",
      );
    } else if (err.type == DioExceptionType.receiveTimeout) {
      weatherException = WeatherException(
        message: "Receive Timeout",
        title: err.response?.statusCode.toString() ?? "",
      );
    } else if (err.type == DioExceptionType.badResponse) {
      debugPrint("Bad response received $err");
      weatherException = WeatherException(
        message: err.response?.data['message'] ?? "Unknown error",
        title: err.response?.statusCode.toString() ?? "",
      );
    } else if (err.type == DioExceptionType.cancel) {
      weatherException = WeatherException(
        message: "Request Cancelled",
        title: err.response?.statusCode.toString() ?? "",
      );
    } else if (err.type == DioExceptionType.connectionError) {
      weatherException = WeatherException(
        title: 'Network Error',
        message: 'Please check your internet connection',
      );
    } else {
      debugPrint("Received unknown exception");
      weatherException = WeatherException(
        message: "Unexpected Error",
        title: err.response?.statusCode.toString() ?? "",
      );
    }

    handler.next(DioException(requestOptions: err.requestOptions, error: weatherException));
  }
}
