import 'dart:async';

import 'package:cgc_project/bloc/search_location_bloc/search_location_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/search_location/get_lat_long_model.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  final String? focusedField;
  final void Function(VoidCallback zoomToFit)? onMapReady;
  final Function(CameraPosition)? onCameraMoveCustomMethod;
  final VoidCallback? onCameraIdleCustomMethod;
  const GoogleMapWidget({
    super.key,
    this.onMapReady,
    this.focusedField,
    this.onCameraMoveCustomMethod,
    this.onCameraIdleCustomMethod,
  });

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  GoogleMapController? mapController;
  BitmapDescriptor? customIcon;
  Completer<GoogleMapController>? controller;
  LatLng? _center;
  LatLng? currentPosition;
  late final SearchLocationBloc locationBloc;
  Set<Marker> get markers => _buildMarkers();

  final List<LatLng> _routeCoords = [
    LatLng(29.33775, 48.02351), // Kuwait
  ];

  @override
  void initState() {
    super.initState();
    locationBloc = getItInstance<SearchLocationBloc>();
    locationBloc.add(GetCurrentLocation());
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    customIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(7.78, 22.8)),
      Images.location,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchLocationBloc, SearchLocationState>(
      builder: (context, state) {
        currentPosition = _getInitialPosition(state);

        return GoogleMap(
          minMaxZoomPreference: const MinMaxZoomPreference(12, 18),
          compassEnabled: false,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          initialCameraPosition: CameraPosition(
            target: currentPosition!,
            zoom: 10,
          ),
          onMapCreated: (controller) {
            this.controller?.complete(controller);
            mapController = controller;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onMapReady?.call(zoomToFitRoute);
            });
          },
          onCameraMove: (CameraPosition position) {
            _center = position.target;
            setState(() {
              _buildMarkers();
            });
            if (widget.onCameraMoveCustomMethod != null) {
              widget.onCameraMoveCustomMethod!(position);
            }
          },
          onCameraIdle: () {
            if (_center != null) _fetchAddressFromLatLng(_center!);
            if (widget.onCameraIdleCustomMethod != null) {
              widget.onCameraIdleCustomMethod!();
            }
          },
          markers: markers,
        );
      },
    );
  }

  LatLng _getInitialPosition(SearchLocationState state) {
    if (state.locationData?.lat != null && state.locationData?.lng != null) {
      return LatLng(state.locationData!.lat!, state.locationData!.lng!);
    }
    return _routeCoords.first;
  }

  Set<Marker> _buildMarkers() {
    LatLng position = _center ?? _routeCoords.first;

    return {
      Marker(
        markerId: MarkerId(
          widget.focusedField == null
              ? 'Location'
              : widget.focusedField! == "pickUp"
              ? 'pickUp'
              : 'Destination',
        ),
        position: position,
        icon:
            customIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow:
            widget.focusedField != null
                ? InfoWindow(
                  title:
                      widget.focusedField! == "pickUp"
                          ? 'PickUp Location'
                          : 'Destination Location',
                )
                : InfoWindow.noText,
      ),
    };
  }

  Future<void> _fetchAddressFromLatLng(LatLng latLng) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        final locationPart =
            placemark.locality ??
            placemark.subLocality ??
            placemark.administrativeArea ??
            placemark.subAdministrativeArea;

        final address = [
          placemark.name,
          if (locationPart != null) locationPart,
          placemark.country,
        ].whereType<String>().join(', ');

        final locationData = LocationModel(
          lat: latLng.latitude,
          lng: latLng.longitude,
          name: placemark.name ?? "",
          address: address,
        );

        locationBloc.add(GetMapLocation(locationData: locationData));
      }
    } catch (_) {
      // handle error if needed
    }
  }

  void zoomToFitRoute({List<LatLng>? routeCords}) {
    final route = routeCords ?? _routeCoords;
    if (route.isEmpty || mapController == null) return;

    final bounds = _createBoundsFromLatLngList(route);

    mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  LatLngBounds _createBoundsFromLatLngList(List<LatLng> list) {
    double? minLat, maxLat, minLng, maxLng;

    for (final latLng in list) {
      if (minLat == null || latLng.latitude < minLat) {
        minLat = latLng.latitude;
      }
      if (maxLat == null || latLng.latitude > maxLat) {
        maxLat = latLng.latitude;
      }
      if (minLng == null || latLng.longitude < minLng) {
        minLng = latLng.longitude;
      }
      if (maxLng == null || latLng.longitude > maxLng) {
        maxLng = latLng.longitude;
      }
    }

    return LatLngBounds(
      southwest: LatLng(minLat!, minLng!),
      northeast: LatLng(maxLat!, maxLng!),
    );
  }
}
