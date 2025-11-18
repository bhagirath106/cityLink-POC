import 'package:cgc_project/bloc/search_location_bloc/search_location_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/route_model/booking_accepted_model.dart';
import 'package:cgc_project/models/route_model/booking_request_model.dart';
import 'package:cgc_project/models/route_model/get_route_data.dart';
import 'package:cgc_project/models/route_model/upcoming_rides_model.dart';
import 'package:cgc_project/models/search_location/set_lat_long_model.dart';
import 'package:cgc_project/repositories/routes/routes_info.dart';
import 'package:cgc_project/repositories/routes/web_socket_service.dart';
import 'package:cgc_project/util/app_messenger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cgc_project/models/Error_model.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'route_event.dart';
part 'route_state.dart';

class RouteBloc extends Bloc<RouteEvent, RouteState> {
  final RoutesInfoRepository getRoutesInfoRepository;
  RouteBloc({required this.getRoutesInfoRepository})
    : super(RouteState.initial()) {
    on<GetRouteInfo>((event, emit) async {
      emit(state.copyWith(status: ApiStatus.loading));
      try {
        final setData =
            getItInstance<SearchLocationBloc>().state.setLatLongData;
        Response response = await getRoutesInfoRepository.getRoutesInfo(
          setData ?? SetLatLongModel(),
        );
        GetRouteDataModel getRouteData = GetRouteDataModel.fromJson(
          response.data,
        );
        if (getRouteData.routes.first.errors.isNotEmpty) {
          emit(
            state.copyWith(
              status: ApiStatus.failure,
              error: ErrorModel.fromJson({
                "error": getRouteData.routes.first.errors.first.toJson(),
              }),
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: ApiStatus.success,
              getRouteData: getRouteData,
            ),
          );
        }
      } on DioException catch (error) {
        emit(
          state.copyWith(
            status: ApiStatus.failure,
            error:
                error.response != null
                    ? ErrorModel.fromJson(error.response?.data)
                    : ErrorModel(error: null),
          ),
        );
      }
    });
    on<BookingRequest>((event, emit) async {
      emit(state.copyWith(bookingStatus: ApiStatus.loading));
      try {
        GetRouteDataModel getRouteData =
            getItInstance<RouteBloc>().state.getRouteData;
        Response response = await getRoutesInfoRepository.confirmBooking(
          getRouteData,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          BookingRequestModel bookingRequestData = BookingRequestModel.fromJson(
            response.data,
          );
          Response upComingResponse =
              await getRoutesInfoRepository.upcomingRides();
          if (upComingResponse.statusCode == 200 ||
              upComingResponse.statusCode == 201) {
            UpComingRidesModel upComingRidesData = UpComingRidesModel.fromJson(
              upComingResponse.data,
            );
            String? bookingId =
                upComingRidesData.upcomingRides.last.upcomingRide?.bookingId;
            Response bookingAcceptedResponse = await getRoutesInfoRepository
                .bookingAccepted(bookingId ?? '');
            if (bookingAcceptedResponse.statusCode == 200 ||
                bookingAcceptedResponse.statusCode == 201) {
              BookingAcceptedModel bookingAcceptedData =
                  BookingAcceptedModel.fromJson(bookingAcceptedResponse.data);
              emit(
                state.copyWith(
                  bookingStatus: ApiStatus.success,
                  bookingRequestData: bookingRequestData,
                  upComingRidesData: upComingRidesData,
                  bookingAcceptedData: bookingAcceptedData,
                ),
              );
              getItInstance<RouteBloc>().add(
                TrackingEvent(
                  url: bookingAcceptedData.booking!.websocketsEventsUrl!,
                ),
              );
            }
          }
        }
      } on DioException catch (error) {
        if (error.type == DioExceptionType.receiveTimeout) {
          AppMessenger.w(error.message ?? '');
          emit(state.copyWith(bookingStatus: ApiStatus.failure));
        } else {
          emit(
            state.copyWith(
              bookingStatus: ApiStatus.failure,
              bookingError:
                  error.response?.data != null
                      ? ErrorModel.fromJson(error.response!.data)
                      : ErrorModel(error: null),
            ),
          );
        }
      }
    });

    on<TrackingEvent>((event, emit) async {
      emit(state.copyWith(trackingStatus: ApiStatus.loading));
      try {
        WebSocketService service = WebSocketService(event.url);
        bool? flag = false;

        service.stream.listen((message) {
          final on = message['on'];
          final data = message['data'];
          if (on == 'booking.vehicle.location') {
            add(UpdateVehicleLocation(lat: data['lat'], lng: data['lng']));
          }
          if (on == 'booking.destinations') {
            flag = true;
          }
          if (flag == true && on == 'segments') {
            final trackingData =
                (data as List)
                    .map(
                      (ele) => BookingAcceptedSegment.fromJson(
                        ele as Map<String, dynamic>,
                      ),
                    )
                    .toList();
            add(TrackingDataReceived(segments: trackingData));
          } else if (flag == true && data == 'closed') {
            add(TrackingClosed());
          } else if (data == 'cancelled') {
            add(TrackingCancelled());
          }
        });
      } catch (e) {
        rethrow;
      }
    });

    on<TrackingDataReceived>((event, emit) {
      emit(
        state.copyWith(
          trackingStatus: ApiStatus.success,
          trackingData: event.segments,
        ),
      );
    });

    on<TrackingClosed>((event, emit) {
      emit(state.copyWith(trackingStatus: ApiStatus.closed));
    });

    on<TrackingCancelled>((event, emit) {
      emit(state.copyWith(trackingStatus: ApiStatus.cancel));
    });

    on<UpdateVehicleLocation>((event, emit) {
      final newLocation = LatLng(event.lat, event.lng);

      // Only emit if the location has changed
      if (state.vehicleLocation != newLocation) {
        emit(
          state.copyWith(
            vehicleLocation: newLocation,
            status: ApiStatus.routeCords,
          ),
        );
      }
    });

    on<SetInitStatus>((event, emit) async {
      emit(
        state.copyWith(
          status: ApiStatus.initial,
          bookingStatus: ApiStatus.initial,
          trackingStatus: ApiStatus.initial,
        ),
      );
    });

    on<CancelRequest>((event, emit) async {
      try {
        Response response = await getRoutesInfoRepository.cancelRequest(
          state.bookingAcceptedData.booking?.id ?? '',
        );
        if (response.statusCode == 204) {
          emit(state.copyWith(bookingStatus: ApiStatus.cancel));
        }
      } on DioException catch (e) {
        if (e.response?.data != null) {
          emit(
            state.copyWith(
              bookingStatus: ApiStatus.failure,
              error: ErrorModel.fromJson(e.response?.data),
            ),
          );
        }
      }
    });
  }
}
