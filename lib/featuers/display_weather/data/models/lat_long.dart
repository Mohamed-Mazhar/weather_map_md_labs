class LatLong {
  double? lat;
  double? long;

  LatLong({
    this.lat,
    this.long,
  });

  factory LatLong.fromJson(Map<String, dynamic> json) {
    return LatLong(
      lat: json['lat'],
      long: json['lon']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "lat": lat,
      "lon": long,
    };
  }
}