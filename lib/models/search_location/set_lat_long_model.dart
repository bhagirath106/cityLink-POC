import 'package:cgc_project/models/search_location/get_lat_long_model.dart';

class SetLatLongModel {
  late final LatLongModel? pickup;
  late final LatLongModel? destination;

  SetLatLongModel({this.pickup, this.destination});

  SetLatLongModel copyWith({LatLongModel? pickup, LatLongModel? destination}) {
    return SetLatLongModel(
      pickup: pickup ?? this.pickup,
      destination: destination ?? this.destination,
    );
  }
}

class LatLongModel {
  final String value;
  final Place place;

  LatLongModel({required this.value, required this.place});
}
