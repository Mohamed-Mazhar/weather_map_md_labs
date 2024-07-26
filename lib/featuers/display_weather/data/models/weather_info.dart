class WeatherInfo {
  String? cityName;
  double? temp;
  String? desc;
  String? image;

  WeatherInfo({
    this.cityName,
    this.temp,
    this.desc,
    this.image,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      cityName: json['name'],
      temp: json['main']['temp'],
      desc: json['weather'][0]['description'],
      image: json['weather'][0]['icon']
    );
  }
}
