part of 'search_location_bloc.dart';

class SearchLocationState extends Equatable {
  final ApiStatus status;
  final ErrorModel? error;
  final AutoCompletionModel? autoCompletionData;
  final GetLatLongModel? getLatLongData;
  final SetLatLongModel? setLatLongData;
  final LocationModel? locationData;
  final LocationModel? locationMapData;
  final ButtonStatus buttonStatus;
  final List<Suggestion>? localSuggestionList;

  const SearchLocationState({
    this.error,
    required this.status,
    this.autoCompletionData,
    this.getLatLongData,
    this.setLatLongData,
    this.locationData,
    this.locationMapData,
    this.localSuggestionList,
    required this.buttonStatus,
  });

  static SearchLocationState initial() => SearchLocationState(
    status: ApiStatus.initial,
    autoCompletionData: AutoCompletionModel(suggestions: [], warnings: []),
    getLatLongData: null,
    setLatLongData: null,
    locationData: null,
    locationMapData: null,
    buttonStatus: ButtonStatus.disabled,
    localSuggestionList: [],
  );

  SearchLocationState copyWith({
    ApiStatus? status,
    ErrorModel? error,
    ButtonStatus? buttonStatus,
    AutoCompletionModel? autoCompletionData,
    GetLatLongModel? getLatLongData,
    SetLatLongModel? setLatLongData,
    LocationModel? locationData,
    LocationModel? locationMapData,
    String? expiresAt,
    List<Suggestion>? localSuggestionList,
  }) {
    return SearchLocationState(
      autoCompletionData: autoCompletionData ?? this.autoCompletionData,
      getLatLongData: getLatLongData ?? this.getLatLongData,
      setLatLongData: setLatLongData ?? this.setLatLongData,
      locationData: locationData ?? this.locationData,
      locationMapData: locationMapData ?? this.locationMapData,
      localSuggestionList: localSuggestionList ?? this.localSuggestionList,
      error: error ?? this.error,
      status: status ?? this.status,
      buttonStatus: buttonStatus ?? this.buttonStatus,
    );
  }

  @override
  List<Object?> get props => [
    status,
    error,
    buttonStatus,
    autoCompletionData,
    locationData,
    locationMapData,
    getLatLongData,
    setLatLongData,
    localSuggestionList,
  ];
}
