import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteBookingMap extends StatefulWidget {
  final void Function(VoidCallback zoomToFit)? onMapReady;
  final String? image;
  final List<String>? encodedPolyLines;

  const RouteBookingMap({
    super.key,
    this.image,
    required this.onMapReady,
    this.encodedPolyLines,
  });

  @override
  State<RouteBookingMap> createState() => _RouteBookingMapState();
}

class _RouteBookingMapState extends State<RouteBookingMap> {
  final GlobalKey<_RouteBookingMapState> _mapKey = GlobalKey();
  late GoogleMapController? mapController;
  BitmapDescriptor? customStartIcon;
  BitmapDescriptor? customEndIcon;
  final Set<Polyline> _polylines = {};

  // Define your own route points manually
  final List<LatLng> _routeCoords = [
    LatLng(29.33775, 48.02351), // kuwait
  ];

  @override
  void initState() {
    super.initState();
    if (widget.encodedPolyLines != null) {
      _setPolylines();
    }
    loadStartCustomMarker();
    loadEndCustomMarker();
  }

  void _setPolylines() {
    final polylinePoints = PolylinePoints();
    _routeCoords.clear();
    for (int i = 0; i < widget.encodedPolyLines!.length; i++) {
      final decodedPoints = polylinePoints.decodePolyline(
        widget.encodedPolyLines![i],
      );

      final latLngPoints =
          decodedPoints.map((e) => LatLng(e.latitude, e.longitude)).toList();

      if (latLngPoints.isNotEmpty) {
        _routeCoords.addAll(latLngPoints);
        _polylines.add(
          Polyline(
            polylineId: PolylineId("route_$i"),
            points: latLngPoints,
            color: Colors.black,
            width: 4,
          ),
        );
      }
    }

    setState(() {}); // Update UI
  }

  void loadStartCustomMarker() async {
    BitmapDescriptor? setIcon;
    setIcon = await BitmapDescriptor.asset(
      ImageConfiguration(
        size: Size(22.8, widget.image == null ? 22.8 : 44),
      ), // You can tweak the size
      widget.image ?? Images.iconBus,
    );
    setState(() {
      customStartIcon = setIcon;
    });
  }

  void loadEndCustomMarker() async {
    BitmapDescriptor? setIcon;
    setIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(22.8, 22.8)), // You can tweak the size
      Images.stopCircle,
    );
    setState(() {
      customEndIcon = setIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RouteBloc, RouteState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == ApiStatus.routeCords) {
          if (state.vehicleLocation != null && mapController != null) {
            _routeCoords.insert(0, state.vehicleLocation!);
            mapController!.animateCamera(
              CameraUpdate.newLatLng(state.vehicleLocation!),
            );
            setState(() {});
          }
        }
      },
      child: GoogleMap(
        key: _mapKey,
        initialCameraPosition: CameraPosition(
          target: _routeCoords.first,
          zoom: 12,
        ),
        onMapCreated: (controller) {
          mapController = controller;
          widget.onMapReady?.call(
            zoomToFitRoute,
          ); // optional: auto zoom on load
        },
        polylines: _polylines,
        markers: {
          if (_routeCoords.isNotEmpty)
            Marker(
              markerId: const MarkerId("start"),
              position: _routeCoords.first,
              icon:
                  customStartIcon ??
                  BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen,
                  ),
              infoWindow: const InfoWindow(title: "Start"),
            ),
          if (_routeCoords.length > 1)
            Marker(
              markerId: const MarkerId("End"),
              position: _routeCoords.last,
              icon:
                  customEndIcon ??
                  BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueRed,
                  ),
              infoWindow: const InfoWindow(title: "End"),
            ),
        },
      ),
    );
  }

  void zoomToFitRoute() {
    if (_routeCoords.isEmpty) return;

    LatLngBounds bounds = _createBoundsFromLatLngList(_routeCoords);

    if (!mounted) return;
    mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50), // 50 is padding
    );
  }

  LatLngBounds _createBoundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;

    for (LatLng latLng in list) {
      if (x0 == null || latLng.latitude < x0) x0 = latLng.latitude;
      if (x1 == null || latLng.latitude > x1) x1 = latLng.latitude;
      if (y0 == null || latLng.longitude < y0) y0 = latLng.longitude;
      if (y1 == null || latLng.longitude > y1) y1 = latLng.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(x0!, y0!),
      northeast: LatLng(x1!, y1!),
    );
  }
}
