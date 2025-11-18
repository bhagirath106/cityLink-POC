part of 'route_bloc.dart';

@immutable
abstract class RouteEvent {}

class GetRouteInfo extends RouteEvent {}

class BookingRequest extends RouteEvent {}

class CancelRequest extends RouteEvent {}

class TrackingEvent extends RouteEvent {
  final String url;
  TrackingEvent({required this.url});
}

class TrackingDataReceived extends RouteEvent {
  final List<BookingAcceptedSegment> segments;

  TrackingDataReceived({required this.segments});
}

class TrackingClosed extends RouteEvent {}

class TrackingCancelled extends RouteEvent {}

class UpdateVehicleLocation extends RouteEvent {
  final double lat;
  final double lng;

  UpdateVehicleLocation({required this.lat, required this.lng});
}

class SetInitStatus extends RouteEvent {}
