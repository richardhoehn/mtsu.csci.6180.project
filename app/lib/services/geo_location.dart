class GeoLocation {
  double lng = 0;
  double lat = 0;

  GeoLocation({required this.lng, required this.lat});

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      lng: (json['lng'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lng': lng,
      'lat': lat,
    };
  }
}