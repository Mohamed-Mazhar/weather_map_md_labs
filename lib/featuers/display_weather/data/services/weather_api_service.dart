import 'package:weather_map_md_labs/core/data/data_sources/apis/api_client.dart';
import 'package:weather_map_md_labs/core/data/data_sources/apis/api_list.dart';
import 'package:weather_map_md_labs/core/data/data_sources/apis/api_result.dart';
import 'package:weather_map_md_labs/core/data/data_sources/exceptions/weather_exception.dart';
import 'package:weather_map_md_labs/featuers/display_weather/data/models/lat_long.dart';
import 'package:weather_map_md_labs/featuers/display_weather/data/models/weather_info.dart';

class WeatherApiService {
  final ApiClient _apiClient;

  WeatherApiService({required ApiClient apiClient}) : _apiClient = apiClient;

  // Future<WeatherInfo?> getWeatherInfo({required String city}) async {
  //   final cityLatLong = await _getCityLatAndLong(city: city);
  //   if (cityLatLong == null) {
  //     throw WeatherException(title: 'Invalid', message: 'Please enter a valid city');
  //   } else {
  //     final response = await _apiClient.getRequest(
  //       endPoint: ApiList.weatherUrl,
  //       parameters: cityLatLong.toJson(),
  //     );
  //     return WeatherInfo.fromJson(response as Map<String, dynamic>);
  //   }
  // }
  //
  // Future<LatLong?> _getCityLatAndLong({required String city}) async {
  //   final response = await _apiClient.getRequest(
  //     endPoint: ApiList.geoCodeUrl,
  //     parameters: {"q": city, "limit": "1"},
  //   );
  //   if (response is List<dynamic> && response.isEmpty) {
  //     return null;
  //   } else {
  //     return LatLong.fromJson((response as List<dynamic>)[0] as Map<String, dynamic>);
  //   }
  // }

  Future<ApiResult<LatLong>> getCityLatLang({required String city}) async {
    try {
      final response = await _apiClient.getRequest(
        endPoint: ApiList.geoCodeUrl,
        parameters: {"q": city, "limit": "1"},
      );
      if (response != null && (response as List).isNotEmpty) {
        return ApiResult.success(LatLong.fromJson(response[0] as Map<String, dynamic>));
      } else {
        return ApiResult.failed("Enter a valid city name");
      }
    } on WeatherException catch (e) {
      return ApiResult.failed(e.message);
    }
  }

  Future<ApiResult<WeatherInfo>> getCityWeatherInfo(LatLong cityLatLong) async {
    try {
      final response = await _apiClient.getRequest(
        endPoint: ApiList.weatherUrl,
        parameters: cityLatLong.toJson(),
      );
      return ApiResult.success(WeatherInfo.fromJson(
        response as Map<String, dynamic>,
      ));
    } on WeatherException catch (e) {
      return ApiResult.failed(e.message);
    }
  }
}
