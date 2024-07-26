class WeatherException implements Exception {
  final String title;
  final String message;

  WeatherException({required this.title, required this.message});

}