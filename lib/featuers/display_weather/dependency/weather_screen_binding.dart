import 'package:get/get.dart';
import 'package:weather_map_md_labs/core/data/data_sources/apis/api_client.dart';
import 'package:weather_map_md_labs/featuers/display_weather/data/services/weather_api_service.dart';
import 'package:weather_map_md_labs/featuers/display_weather/presentation/controllers/weather_screen_controller.dart';

class WeatherScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiClient.instance());
    Get.lazyPut(() => WeatherApiService(apiClient: Get.find<ApiClient>()));
    Get.lazyPut(() => WeatherScreenController(weatherApiService: Get.find<WeatherApiService>()));
  }

}