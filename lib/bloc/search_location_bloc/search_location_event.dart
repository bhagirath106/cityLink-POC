part of 'search_location_bloc.dart';

@immutable
abstract class SearchLocationEvent {}

class OnSearchEvent extends SearchLocationEvent {
  final String location;
  OnSearchEvent({required this.location});
}

class OnAutoCompleteClearEvent extends SearchLocationEvent {}

class GetLatLongEvent extends SearchLocationEvent {
  final Suggestion suggestionData;
  GetLatLongEvent({required this.suggestionData});
}

class SetPickupOrDestinationEvent extends SearchLocationEvent {
  final LatLongModel latLong;

  SetPickupOrDestinationEvent({required this.latLong});
}

class GetCurrentLocation extends SearchLocationEvent {}

class GetMapLocation extends SearchLocationEvent {
  final LocationModel locationData;
  GetMapLocation({required this.locationData});
}

class GetLocalList extends SearchLocationEvent {}
