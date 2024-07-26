import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_map_md_labs/featuers/display_weather/data/models/weather_info.dart';
import 'package:weather_map_md_labs/featuers/display_weather/presentation/controllers/weather_screen_controller.dart';
import 'package:weather_map_md_labs/widgets/app_primary_button.dart';
import 'package:weather_map_md_labs/widgets/loader.dart';
import 'package:weather_map_md_labs/widgets/text_input.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WeatherScreenController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Show weather info',
          style: TextStyle(
            fontSize: 18,
            color: Colors.blueGrey,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                TextInput(
                  label: 'Enter city name',
                  textEditingController: controller.cityController,
                ),
                const SizedBox(height: 12),
                Obx(
                  () {
                    return AppPrimaryButton(
                      isEnabled: controller.isButtonActive.value,
                      text: 'Get',
                      onTap: () {
                        controller.getWeatherInfo();
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),
                Obx(() {
                  return WeatherInformationWidget(weatherInfo: controller.weatherInfo.value);
                }),
              ],
            ),
          ),
          Obx(() {
            return controller.isLoading.value ? const Loader() : const SizedBox();
          }),
        ],
      ),
    );
  }
}

class WeatherInformationWidget extends StatelessWidget {
  final WeatherInfo? weatherInfo;

  const WeatherInformationWidget({super.key, this.weatherInfo});

  @override
  Widget build(BuildContext context) {
    if (weatherInfo == null) {
      return const SizedBox();
    } else {
      return DecoratedBox(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blueAccent)),
        child: Column(
          children: [
            Image.network(
              "http://openweathermap.org/img/w/${weatherInfo!.image!}.png",
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
            ),
            _weatherInfo(title: 'Name', value: weatherInfo!.cityName!),
            _weatherInfo(title: 'Description', value: weatherInfo!.desc!),
            _weatherInfo(title: 'Temperature', value: weatherInfo!.temp.toString()),
          ],
        ),
      );
    }
  }

  Padding _weatherInfo({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.blueAccent)),
        ],
      ),
    );
  }
}
