import 'package:cgc_project/models/search_location/get_lat_long_model.dart';
import 'package:cgc_project/models/search_location/set_lat_long_model.dart';
import 'package:cgc_project/service/local_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cgc_project/models/search_location/auto_completion_model.dart';
import 'package:cgc_project/repositories/auto_completion_location/auto_completion.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/Error_model.dart';
import '../../util/constant/enum.dart';

part 'search_location_event.dart';
part 'search_location_state.dart';

class SearchLocationBloc
    extends Bloc<SearchLocationEvent, SearchLocationState> {
  final AutoCompletionLocationRepository autoCompletionLocationRepository;
  SearchLocationBloc({required this.autoCompletionLocationRepository})
    : super(SearchLocationState.initial()) {
    on<OnSearchEvent>((event, emit) async {
      emit(state.copyWith(status: ApiStatus.loading));
      try {
        Response response;
        var uuid = Uuid();
        response = await autoCompletionLocationRepository.locationSearch(
          event.location,
          uuid.v4(),
        );
        if (response.statusCode == 200) {
          emit(
            state.copyWith(
              status: ApiStatus.success,
              autoCompletionData: AutoCompletionModel.fromJson(response.data),
            ),
          );
        }
      } on DioException catch (e) {
        emit(
          state.copyWith(
            status: ApiStatus.failure,
            error:
                e.response?.data != null
                    ? ErrorModel.fromJson(e.response!.data)
                    : null,
          ),
        );
      }
    });
    on<OnAutoCompleteClearEvent>((event, emit) {
      emit(state.copyWith(status: ApiStatus.initial, autoCompletionData: null));
    });
    on<GetLatLongEvent>((event, emit) async {
      emit(state.copyWith(status: ApiStatus.loading));
      try {
        Response response;
        var uuid = Uuid();
        response = await autoCompletionLocationRepository.getLatLong(
          event.suggestionData.id!,
          uuid.v4(),
        );
        if (response.statusCode == 200) {
          emit(
            state.copyWith(
              status: ApiStatus.getLatLongSuccess,
              getLatLongData: GetLatLongModel.fromJson(response.data),
            ),
          );
        }
      } on DioException catch (e) {
        emit(
          state.copyWith(
            status: ApiStatus.failure,
            error:
                e.response?.data != null
                    ? ErrorModel.fromJson(e.response?.data)
                    : null,
          ),
        );
      }
    });

    on<SetPickupOrDestinationEvent>((event, emit) {
      // Use existing data or create a new instance
      final currentData =
          state.setLatLongData ??
          SetLatLongModel(
            pickup: LatLongModel(
              value: '',
              place: Place(id: '', provider: '', location: state.locationData),
            ),
          );

      final updatedData = currentData.copyWith(
        pickup:
            event.latLong.value == 'start' ? event.latLong : currentData.pickup,
        destination:
            event.latLong.value == 'end'
                ? event.latLong
                : currentData.destination,
      );

      emit(
        state.copyWith(
          setLatLongData: updatedData,
          status:
              updatedData.pickup?.place.location != null &&
                      updatedData.destination?.place.location != null
                  ? ApiStatus.navigate
                  : ApiStatus.initial,
        ),
      );
    });

    on<GetCurrentLocation>((event, emit) async {
      LocationModel data =
          await AutoCompletionLocationRepository.getCurrentLocation();
      emit(state.copyWith(locationData: data));
    });
    on<GetMapLocation>((event, emit) async {
      emit(state.copyWith(locationMapData: event.locationData));
    });
    on<GetLocalList>((event, emit) async {
      final suggestions = await LocalStorageServices.getSuggestionList();
      if (state.setLatLongData?.pickup?.place.location != null) {
        suggestions.removeWhere(
          (item) => item.id == state.setLatLongData?.pickup?.place.id,
        );
      }
      emit(state.copyWith(localSuggestionList: suggestions));
    });
  }
}
