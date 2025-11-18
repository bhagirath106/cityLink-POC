part of 'route_bloc.dart';

class RouteState extends Equatable {
  final ApiStatus status;
  final ApiStatus? bookingStatus;
  final ErrorModel? error;
  final ErrorModel? bookingError;
  final ButtonStatus buttonStatus;
  final GetRouteDataModel getRouteData;
  final BookingRequestModel bookingRequestData;
  final UpComingRidesModel upComingRidesData;
  final BookingAcceptedModel bookingAcceptedData;
  final ApiStatus? trackingStatus;
  final List<BookingAcceptedSegment>? trackingData;
  final LatLng? vehicleLocation;

  const RouteState({
    this.error,
    required this.status,
    required this.buttonStatus,
    required this.getRouteData,
    required this.bookingRequestData,
    this.bookingError,
    this.bookingStatus,
    required this.upComingRidesData,
    required this.bookingAcceptedData,
    this.trackingStatus,
    this.trackingData,
    this.vehicleLocation,
  });

  static RouteState initial() => RouteState(
    status: ApiStatus.initial,
    buttonStatus: ButtonStatus.disabled,
    getRouteData: GetRouteDataModel(routes: []),
    bookingRequestData: BookingRequestModel(
      bookingRequest: null,
      regionId: '',
      segments: [],
      bookingRequestModelOperator: null,
      payment: null,
    ),
    error: null,
    bookingError: null,
    vehicleLocation: null,
    bookingStatus: ApiStatus.initial,
    upComingRidesData: UpComingRidesModel(upcomingRides: []),
    bookingAcceptedData: BookingAcceptedModel(
      booking: null,
      segments: [],
      payment: null,
    ),
    trackingStatus: ApiStatus.initial,
    trackingData: [],
  );

  RouteState copyWith({
    ApiStatus? status,
    ErrorModel? error,
    ButtonStatus? buttonStatus,
    GetRouteDataModel? getRouteData,
    BookingRequestModel? bookingRequestData,
    ApiStatus? bookingStatus,
    ErrorModel? bookingError,
    UpComingRidesModel? upComingRidesData,
    BookingAcceptedModel? bookingAcceptedData,
    ApiStatus? trackingStatus,
    List<BookingAcceptedSegment>? trackingData,
    LatLng? vehicleLocation,
  }) {
    return RouteState(
      error: error ?? this.error,
      status: status ?? this.status,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      getRouteData: getRouteData ?? this.getRouteData,
      bookingRequestData: bookingRequestData ?? this.bookingRequestData,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      bookingError: bookingError ?? this.bookingError,
      upComingRidesData: upComingRidesData ?? this.upComingRidesData,
      bookingAcceptedData: bookingAcceptedData ?? this.bookingAcceptedData,
      trackingStatus: trackingStatus ?? this.trackingStatus,
      trackingData: trackingData ?? this.trackingData,
      vehicleLocation: vehicleLocation ?? this.vehicleLocation,
    );
  }

  @override
  List<Object?> get props => [
    status,
    error,
    buttonStatus,
    getRouteData,
    bookingRequestData,
    bookingStatus,
    bookingError,
    upComingRidesData,
    bookingAcceptedData,
    trackingStatus,
    trackingData,
    vehicleLocation,
  ];
}
