import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_map_md_labs/featuers/display_weather/data/models/weather_info.dart';
import 'package:weather_map_md_labs/featuers/display_weather/data/services/weather_api_service.dart';

class WeatherScreenController extends GetxController {
  final WeatherApiService _weatherApiService;

  late TextEditingController cityController;
  RxBool isButtonActive = false.obs;
  RxBool isLoading = false.obs;
  Rxn<WeatherInfo> weatherInfo = Rxn();

  WeatherScreenController({
    required WeatherApiService weatherApiService,
  }) : _weatherApiService = weatherApiService;

  @override
  void onInit() {
    cityController = TextEditingController();
    cityController.addListener(() {
      if (cityController.text.isNotEmpty) {
        isButtonActive(true);
      } else {
        isButtonActive(false);
      }
    });
    super.onInit();
  }

  //Using Api Response class
  Future<void> getWeather() async {
    weatherInfo.value = null;
    isLoading(true);
    final latLangResponse = await _weatherApiService.getCityLatLang(city: cityController.text);
    if (!latLangResponse.success) {
      isLoading(false);
      showError("Please enter a valid city name");
    } else {
      final weatherInfoResponse = await _weatherApiService.getCityWeatherInfo(latLangResponse.data!);
      isLoading(false);
      if (weatherInfoResponse.success) {
        weatherInfo.value = weatherInfoResponse.data;
      } else {
        showError(weatherInfoResponse.error ?? "");
      }
    }
  }

//Using weather Exception directly
// Future<void> getWeatherInfo() async {
//   weatherInfo.value = null;
//   isLoading(true);
//   try {
//     final response = await _weatherApiService.getWeatherInfo(city: cityController.text);
//     weatherInfo(response);
//     isLoading(false);
//   } on WeatherException catch (e) {
//     isLoading(false);
//     showError(e.message);
//   } catch (e) {
//     isLoading(false);
//     showError("Unknown Error");
//   }
// }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  void showError(String message) {
    Get.snackbar('Error', message,
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.easeInOutCubic,
        reverseAnimationCurve: Curves.easeInOutCubic,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ));
  }
}
