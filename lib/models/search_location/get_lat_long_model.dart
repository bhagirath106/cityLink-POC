class GetLatLongModel {
  GetLatLongModel({required this.place});

  final Place? place;

  factory GetLatLongModel.fromJson(Map<String, dynamic> json) {
    return GetLatLongModel(
      place: json["place"] == null ? null : Place.fromJson(json["place"]),
    );
  }

  Map<String, dynamic> toJson() => {"place": place?.toJson()};
}

class Place {
  Place({required this.id, required this.provider, required this.location});

  final String? id;
  final String? provider;
  final LocationModel? location;

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json["id"],
      provider: json["provider"],
      location:
          json["location"] == null
              ? null
              : LocationModel.fromJson(json["location"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "provider": provider,
    "location": location?.toJson(),
  };
}

class LocationModel {
  LocationModel({
    required this.lat,
    required this.lng,
    required this.name,
    required this.address,
  });

  final double? lat;
  final double? lng;
  final String? name;
  final String? address;

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lat: json["lat"],
      lng: json["lng"],
      name: json["name"],
      address: json["address"],
    );
  }

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
    "name": name,
    "address": address,
  };
}
