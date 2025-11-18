import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/bloc/search_location_bloc/search_location_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/search_location/auto_completion_model.dart';
import 'package:cgc_project/models/search_location/set_lat_long_model.dart';
import 'package:cgc_project/routing/routes.dart';
import 'package:cgc_project/screens/map_route_selection_screen/widget/google_map_widget.dart';
import 'package:cgc_project/service/local_storage_service.dart';
import 'package:cgc_project/util/common_method.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController pickUpController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  final FocusNode pickUpFocus = FocusNode();
  final FocusNode destinationFocus = FocusNode();
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  final Key _sheetKey = UniqueKey();
  String autoFocus = 'none';
  String focusedField =
      "pickUp"; //if true then value set in pickController else destinationController.

  bool toggle = true;
  bool isSetCurrentLocation = false;
  bool firstBlocSuccess = false;
  bool isSearchScreen = false;
  bool isCameraMoving = false;
  bool showButton = false;
  bool showBottomSheet = true;
  bool isSetFromMap = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isSearchScreen = true;
    });
    SearchLocationState searchLocationState =
        getItInstance<SearchLocationBloc>().state;
    pickUpController.text =
        searchLocationState.setLatLongData?.pickup?.place.location?.address ??
        searchLocationState.locationData?.address ??
        '';
    if (pickUpController.text.isEmpty) {
      autoFocus = 'pickUp';
    }

    pickUpFocus.addListener(() {
      if (pickUpFocus.hasFocus) {
        setState(() {
          focusedField = "pickUp";
        });
      }
    });
    destinationFocus.addListener(() {
      if (destinationFocus.hasFocus) {
        setState(() {
          focusedField = "destination";
        });
      }
    });
  }

  onToggle() {
    setState(() {
      toggle = !toggle;
      showBottomSheet = true;
      showButton = false;
      isSetFromMap = false;
    });
    _waitForAttachmentThenAnimate();
  }

  void _waitForAttachmentThenAnimate() async {
    const int maxAttempts = 10;
    int attempt = 0;

    while (!_controller.isAttached && attempt < maxAttempts) {
      await Future.delayed(Duration(seconds: 1));
      attempt++;
    }

    if (_controller.isAttached) {
      _controller.animateTo(
        toggle ? 1.0 : 0.0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  //This method i have created to set current location in google map
  // through this we are checking whether setCurrentLocation button is clicked or not.
  onSetCurrentLocation(bool isSet) {
    setState(() {
      isSetCurrentLocation = isSet;
    });
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return PopScope(
      onPopInvokedWithResult: (_, _) {
        setState(() {
          isSearchScreen = false;
        });
        _clearSearch(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colorScheme.onPrimaryContainer,
          foregroundColor: colorScheme.primary,
          toolbarHeight: size.height / 7,
          title: Text(Labels.planTrip),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(size.height / 17),
            child: BlocListener<SearchLocationBloc, SearchLocationState>(
              listener: (context, state) {
                if (state.locationMapData != null && !toggle) {
                  if (focusedField == "pickUp") {
                    pickUpController.text = state.locationMapData!.address!;
                  } else if (focusedField == "destination") {
                    destinationController.text =
                        state.locationMapData!.address!;
                  }
                }
              },
              child: buildSearchPickUpAndDestinationColumn(
                textTheme,
                colorScheme,
                size,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            if (!toggle)
              Positioned.fill(
                child: GoogleMapWidget(
                  focusedField: focusedField,
                  onCameraMoveCustomMethod: (_) {
                    if (!isCameraMoving) {
                      setState(() {
                        isCameraMoving = true;
                        showButton = false;
                        showBottomSheet = false;
                      });
                    }
                  },
                  onCameraIdleCustomMethod: () {
                    if (!toggle) {
                      setState(() {
                        isCameraMoving = false;
                        showButton = true;
                      });
                    }
                  },
                ),
              ),
            if (!toggle && showButton)
              Positioned(
                bottom: size.height / 35,
                left: size.width / 25,
                child: BlocListener<SearchLocationBloc, SearchLocationState>(
                  listenWhen: (old, prev) => old.status != prev.status,
                  listener: (context, state) {
                    if (state.status == ApiStatus.success && isSetFromMap) {
                      var suggestions =
                          state.autoCompletionData?.suggestions ?? [];
                      if (suggestions.isNotEmpty) {
                        // addSuggestion(suggestions.first);
                        getItInstance<SearchLocationBloc>().add(
                          GetLatLongEvent(suggestionData: suggestions.first),
                        );
                      }
                      isSetFromMap = false;
                    }
                    if (state.status == ApiStatus.getLatLongSuccess) {
                      onToggle();
                    }
                  },
                  child: CustomButton(
                    onPressed: () {
                      if (focusedField == "pickUp") {
                        if (pickUpController.text.isNotEmpty) {
                          getItInstance<SearchLocationBloc>().add(
                            OnSearchEvent(location: pickUpController.text),
                          );
                        }
                      } else if (focusedField == "destination") {
                        if (destinationController.text.isNotEmpty) {
                          getItInstance<SearchLocationBloc>().add(
                            OnSearchEvent(location: destinationController.text),
                          );
                        }
                      }

                      setState(() {
                        isSetFromMap = true;
                      });
                    },
                    labels: Labels.confirmLocation,
                  ),
                ),
              ),
            if (showBottomSheet)
              buildDraggableScrollableSheet(size, colorScheme),
          ],
        ),
      ),
    );
  }

  Padding buildSearchPickUpAndDestinationColumn(
    TextTheme textTheme,
    ColorScheme colorScheme,
    Size size,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height / 100,
        horizontal: size.width / 50,
      ),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width / 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        focusedField == "pickUp"
                            ? Row(
                              children: [
                                const CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Colors.green,
                                ),
                                Icon(
                                  Icons.play_arrow,
                                  key: ValueKey("pickUp"),
                                  size: 16,
                                  color: Colors.green,
                                ),
                              ],
                            )
                            : const CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.green,
                            ),
                  ),
                  Container(
                    width: 2,
                    height: 40,
                    margin: EdgeInsets.only(left: size.width / 90),
                    color: colorScheme.onTertiaryContainer.withAlpha(70),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child:
                        focusedField == "destination"
                            ? Row(
                              children: [
                                const CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Colors.red,
                                ),
                                Icon(
                                  Icons.play_arrow,
                                  key: ValueKey("destination"),
                                  size: 16,
                                  color: Colors.red,
                                ),
                              ],
                            )
                            : const CircleAvatar(
                              radius: 6,
                              backgroundColor: Colors.red,
                            ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Column(
                children: [
                  TextFormField(
                    controller: pickUpController,
                    focusNode: pickUpFocus,
                    onChanged: (String value) {
                      if (value.length > 2) {
                        getItInstance<SearchLocationBloc>().add(
                          OnSearchEvent(location: value),
                        );
                        onSetCurrentLocation(false);
                      }
                    },
                    autofocus: autoFocus == 'pickUp' ? true : false,
                    onTap: () {
                      if (!toggle) {
                        onToggle();
                      }
                    },
                    style: textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.ellipsis,
                      color:
                          focusedField == "pickUp"
                              ? colorScheme.tertiaryContainer
                              : colorScheme.onTertiaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      // filled: true,
                      hintText: Labels.pickUp,
                      hintStyle: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.primary.withAlpha(60),
                        fontWeight: FontWeight.w500,
                      ),
                      // fillColor: colorScheme.secondary,
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffix: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: pickUpController,
                        builder: (context, value, child) {
                          return BlocBuilder<
                            SearchLocationBloc,
                            SearchLocationState
                          >(
                            builder: (context, state) {
                              final isLoading =
                                  state.status == ApiStatus.loading &&
                                  focusedField == "pickUp";

                              final iconColor =
                                  focusedField == "pickUp"
                                      ? colorScheme.tertiaryContainer
                                      : colorScheme.onTertiaryContainer;

                              if (isLoading) {
                                return Container(
                                  width: size.width / 25,
                                  height: size.width / 25,
                                  padding: EdgeInsets.only(
                                    left: size.width / 100,
                                  ),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: iconColor,
                                  ),
                                );
                              }

                              if (value.text.isEmpty) {
                                return SizedBox.shrink();
                              }

                              return GestureDetector(
                                onTap: () {
                                  getItInstance<SearchLocationBloc>().add(
                                    OnAutoCompleteClearEvent(),
                                  );
                                  pickUpController.clear();
                                  onSetCurrentLocation(false);
                                  setAutoFocus("pickUp");
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: size.width / 100,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: iconColor,
                                    size: size.width / 25,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: destinationController,
                    focusNode: destinationFocus,
                    onChanged: (String value) {
                      if (value.length > 2) {
                        getItInstance<SearchLocationBloc>().add(
                          OnSearchEvent(location: value),
                        );
                        onSetCurrentLocation(false);
                      }
                    },
                    onTap: () {
                      if (!toggle) {
                        onToggle();
                      }
                    },
                    autofocus: autoFocus == 'none' ? true : false,
                    style: textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.ellipsis,
                      color:
                          focusedField == "destination"
                              ? colorScheme.tertiaryContainer
                              : colorScheme.onTertiaryContainer,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      hintText: Labels.destination,
                      hintStyle: textTheme.bodyMedium!.copyWith(
                        color: colorScheme.primary.withAlpha(60),
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffix: ValueListenableBuilder<TextEditingValue>(
                        valueListenable: destinationController,
                        builder: (context, value, child) {
                          return BlocBuilder<
                            SearchLocationBloc,
                            SearchLocationState
                          >(
                            builder: (context, state) {
                              final isLoading =
                                  state.status == ApiStatus.loading &&
                                  focusedField == "destination";

                              final isEmpty = value.text.isEmpty;

                              final iconColor =
                                  focusedField == "destination"
                                      ? colorScheme.tertiaryContainer
                                      : colorScheme.onTertiaryContainer;

                              Widget iconWidget;
                              if (isLoading) {
                                iconWidget = Container(
                                  width: 18,
                                  height: 18,
                                  padding: EdgeInsets.only(
                                    left: size.width / 100,
                                  ),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: iconColor,
                                  ),
                                );
                              } else if (isEmpty) {
                                iconWidget = SizedBox.shrink();
                              } else {
                                iconWidget = GestureDetector(
                                  onTap: () {
                                    getItInstance<SearchLocationBloc>().add(
                                      OnAutoCompleteClearEvent(),
                                    );
                                    destinationController.clear();
                                    onSetCurrentLocation(false);
                                    setAutoFocus('none');
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: size.width / 100,
                                    ),
                                    child: Icon(
                                      Icons.close,
                                      color: iconColor,
                                      size: 18,
                                    ),
                                  ),
                                );
                              }

                              return AnimatedSwitcher(
                                duration: Duration(milliseconds: 250),
                                child: iconWidget,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setAutoFocus(String value) {
    setState(() {
      autoFocus = value;
    });
  }

  DraggableScrollableSheet buildDraggableScrollableSheet(
    Size size,
    ColorScheme colorScheme,
  ) {
    return DraggableScrollableSheet(
      key: _sheetKey,
      controller: _controller,
      initialChildSize: 1,
      minChildSize: 0.0,
      maxChildSize: 1,
      snap: true,
      snapSizes: [0.0, 1.0],
      builder: (context, scrollController) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            return sheetNotificationListener(notification);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MultiBlocListener(
                    listeners: [
                      // First BlocListener - SearchLocationBloc
                      BlocListener<SearchLocationBloc, SearchLocationState>(
                        listenWhen:
                            (prev, curr) =>
                                prev.status != curr.status && isSearchScreen,
                        listener:
                            (context, state) =>
                                _handleSearchLocationState(context, state),
                      ),
                      // Second BlocListener - RouteBloc
                      BlocListener<RouteBloc, RouteState>(
                        listenWhen:
                            (prev, curr) =>
                                prev.status != curr.status && isSearchScreen,
                        listener:
                            (context, state) =>
                                _handleRouteState(context, state),
                      ),
                    ],
                    child: BlocBuilder<SearchLocationBloc, SearchLocationState>(
                      builder:
                          (context, state) => _buildSuggestionsList(
                            context,
                            state,
                            scrollController,
                          ),
                    ),
                  ),
                ),

                Column(
                  children: [
                    Container(
                      width: size.width / 1.04,
                      height: size.height / 1000,
                      color: colorScheme.onTertiaryContainer.withAlpha(90),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _dismissKeyboard(context);
                            getItInstance<SearchLocationBloc>().add(
                              OnAutoCompleteClearEvent(),
                            );
                            onToggle();
                            onSetCurrentLocation(toggle);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width / 30,
                              vertical: size.height / 50,
                            ),
                            margin: EdgeInsets.only(
                              left: size.width / 40,
                              right: size.width / 40,
                              // top: size.height / 80,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.pin_drop_outlined,
                                      color: colorScheme.primary,
                                      size: size.width / 25,
                                    ),
                                    SizedBox(width: size.width / 22),
                                    Text(
                                      Labels.setLocationFromMap,
                                      style: TextStyle(
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: size.height / 30,
                          width: size.width / 300,
                          // margin: EdgeInsets.only(top: size.height / 90),
                          color: colorScheme.onTertiaryContainer,
                        ),
                        BlocListener<SearchLocationBloc, SearchLocationState>(
                          listener: (context, state) {
                            if (state.locationData != null &&
                                isSetCurrentLocation) {
                              final String setCurrentLocation =
                                  state.locationData!.name ?? '';
                              if (focusedField == "pickUp") {
                                pickUpController.text = setCurrentLocation;
                              } else if (focusedField == "destination") {
                                destinationController.text = setCurrentLocation;
                              }
                              getItInstance<SearchLocationBloc>().add(
                                OnSearchEvent(
                                  location: setCurrentLocation.trim(),
                                ),
                              );
                              onSetCurrentLocation(false);
                            }
                          },
                          child: GestureDetector(
                            onTap: () {
                              _dismissKeyboard(context);
                              getItInstance<SearchLocationBloc>().add(
                                GetCurrentLocation(),
                              );
                              if (!toggle) {
                                onToggle();
                              }
                              onSetCurrentLocation(true);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width / 30,
                                vertical: size.height / 50,
                              ),
                              margin: EdgeInsets.only(
                                left: size.width / 40,
                                right: size.width / 40,
                                // top: size.height / 80,
                              ),

                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.my_location,
                                        color: colorScheme.primary,
                                        size: size.width / 25,
                                      ),
                                      SizedBox(width: size.width / 22),
                                      Text(
                                        Labels.getCurrentLocation,
                                        style: TextStyle(
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool sheetNotificationListener(DraggableScrollableNotification notification) {
    if (notification.extent == notification.minExtent) {
      if (mounted) setState(() => toggle = false);
    }
    return true;
  }

  void _handleSearchLocationState(
    BuildContext context,
    SearchLocationState state,
  ) {
    if (state.status == ApiStatus.getLatLongSuccess) {
      final isPickupValue = focusedField;
      final placeData = state.getLatLongData?.place;

      if (placeData != null) {
        if (focusedField == "pickUp") {
          pickUpController.text =
              placeData.location?.address ?? placeData.location?.name ?? '';
        } else if (focusedField == "destination") {
          destinationController.text =
              placeData.location?.address ?? placeData.location?.name ?? '';
        }
        getItInstance<SearchLocationBloc>().add(
          SetPickupOrDestinationEvent(
            latLong: LatLongModel(
              value: isPickupValue == "pickUp" ? 'start' : 'end',
              place: placeData,
            ),
          ),
        );
      }
      getItInstance<SearchLocationBloc>().add(OnAutoCompleteClearEvent());
    } else if (isSearchScreen &&
        state.status == ApiStatus.navigate &&
        pickUpController.text.length > 4 &&
        destinationController.text.length > 4) {
      firstBlocSuccess = true;
      getItInstance<RouteBloc>().add(GetRouteInfo());
      getItInstance<SearchLocationBloc>().add(OnAutoCompleteClearEvent());
    } else if (state.status == ApiStatus.failure) {
      _handleSearchError(context, state.error);
      getItInstance<SearchLocationBloc>().add(OnAutoCompleteClearEvent());
    }
  }

  void _handleRouteState(BuildContext context, RouteState state) {
    if (state.status == ApiStatus.failure && firstBlocSuccess) {
      _handleRouteError(context, state.error);
      getItInstance<SearchLocationBloc>().add(OnAutoCompleteClearEvent());
      firstBlocSuccess = false;
    } else if (state.status == ApiStatus.success && firstBlocSuccess) {
      Navigator.pushNamed(context, RoutesName.routeBookingScreen);
      firstBlocSuccess = false;
    }
  }

  Widget _buildSuggestionsList(
    BuildContext context,
    SearchLocationState state,
    ScrollController scrollController,
  ) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final isInitial = state.status == ApiStatus.initial;
    var suggestions =
        isInitial
            ? state.localSuggestionList
            : state.autoCompletionData?.suggestions ?? [];

    suggestions = _filterSelectedLocations(state, suggestions ?? []);

    if (state.status == ApiStatus.loading && toggle) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 5));
    }

    if (suggestions.isEmpty && state.status == ApiStatus.success) {
      return Center(
        child: Text(
          Labels.noLocation,
          style: textTheme.bodyLarge!.copyWith(
            color: colorScheme.tertiaryContainer,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 2, bottom: 2, left: 8),
      controller: scrollController,
      itemCount: suggestions.length,
      itemBuilder:
          (context, index) =>
              _buildSuggestionItem(context, suggestions![index], isInitial),
    );
  }

  List<Suggestion> _filterSelectedLocations(
    SearchLocationState state,
    List<Suggestion> suggestions,
  ) {
    final selectedId =
        focusedField == "pickUp"
            ? state.setLatLongData?.destination?.place.id
            : state.setLatLongData?.pickup?.place.id;

    return selectedId != null
        ? suggestions.where((item) => item.id != selectedId).toList()
        : suggestions;
  }

  Widget _buildSuggestionItem(
    BuildContext context,
    Suggestion item,
    bool isInitial,
  ) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return ListTile(
      title: Text(
        item.name ?? '',
        style: textTheme.bodyLarge!.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        item.address ?? '',
        style: textTheme.bodyMedium!.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w300,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        getItInstance<SearchLocationBloc>().add(
          GetLatLongEvent(suggestionData: item),
        );
        addSuggestion(item);
      },
      trailing: Icon(
        Icons.north_west,
        color: colorScheme.primary.withAlpha(80),
      ),
      leading: Icon(
        isInitial ? Icons.history : Icons.location_on_outlined,
        size: size.width / 25,
        color: colorScheme.primary.withAlpha(99),
      ),
    );
  }

  void _clearSearch(BuildContext context) {
    getItInstance<SearchLocationBloc>().add(OnAutoCompleteClearEvent());
    pickUpController.clear();
    destinationController.clear();
    _dismissKeyboard(context);
  }

  void _handleSearchError(BuildContext context, dynamic error) {
    final userFriendly = error?.error?.userFriendly;
    if (userFriendly != null) {
      CommonMethods.showSimpleDialog(
        context,
        userFriendly.title ?? "",
        userFriendly.description ?? '',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error?.error?.message ?? Labels.somethingWentWrong),
        ),
      );
    }
    getItInstance<SearchLocationBloc>().add(OnAutoCompleteClearEvent());
  }

  void _handleRouteError(BuildContext context, dynamic error) {
    final userFriendly = error?.error?.userFriendly;
    if (userFriendly != null) {
      CommonMethods.showSimpleDialog(
        context,
        userFriendly.title ?? "",
        userFriendly.description ?? '',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error?.error?.message ?? Labels.somethingWentWrong),
        ),
      );
    }
  }

  Future<void> addSuggestion(Suggestion newSuggestion) async {
    List<Suggestion> suggestions =
        await LocalStorageServices.getSuggestionList();

    // Remove duplicate if exists
    suggestions.removeWhere((s) => s.address == newSuggestion.address);

    // Add the new suggestion to the front
    suggestions.insert(0, newSuggestion);

    // Keep only the latest 10 suggestions
    if (suggestions.length > 10) {
      suggestions = suggestions.sublist(0, 10);
    }

    await LocalStorageServices.setSuggestionList(suggestions);
  }

  void _dismissKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
