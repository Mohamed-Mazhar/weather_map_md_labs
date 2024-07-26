import 'package:weather_map_md_labs/core/data/data_sources/apis/api_client.dart';
import 'package:weather_map_md_labs/core/data/data_sources/apis/api_list.dart';
import 'package:weather_map_md_labs/featuers/display_weather/data/models/lat_long.dart';
import 'package:weather_map_md_labs/featuers/display_weather/data/models/weather_info.dart';

class WeatherApiService {
  final ApiClient _apiClient;

  WeatherApiService({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<WeatherInfo?> getWeatherInfo({required String city}) async {
    final cityLatLong = await _getCityLatAndLong(city: city);
    if (cityLatLong == null) {
      return null;
    } else {
      final response = await _apiClient.getRequest(
        endPoint: ApiList.weatherUrl,
        parameters: cityLatLong.toJson(),
      );
      return WeatherInfo.fromJson(response as Map<String, dynamic>);
    }
  }

  Future<LatLong?> _getCityLatAndLong({required String city}) async {
    final response = await _apiClient.getRequest(
      endPoint: ApiList.geoCodeUrl,
      parameters: {"q": city, "limit": "1"},
    );
    if (response is List<dynamic> && response.isEmpty) {
      return null;
    } else {
      return LatLong.fromJson((response as List<dynamic>)[0] as Map<String, dynamic>);
    }
  }
}
