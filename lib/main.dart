import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_map_md_labs/featuers/display_weather/dependency/weather_screen_binding.dart';
import 'package:weather_map_md_labs/featuers/display_weather/presentation/screens/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WeatherScreen(),
      initialBinding: WeatherScreenBinding(),
    );
  }
}
