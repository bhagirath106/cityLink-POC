import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/models/route_model/get_route_data.dart';
import 'package:cgc_project/screens/route_booking_screen/widget/route_booking_widget.dart';
import 'package:cgc_project/widgets/route_booking_map.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteBookingScreen extends StatefulWidget {
  const RouteBookingScreen({super.key});

  @override
  State<RouteBookingScreen> createState() => _RouteBookingScreenState();
}

class _RouteBookingScreenState extends State<RouteBookingScreen> {
  VoidCallback? triggerZoom;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<RouteBloc, RouteState>(
            builder: (context, state) {
              return RouteBookingMap(
                encodedPolyLines: getPolylineList(state.getRouteData),
                onMapReady: (zoomFunc) {
                  setState(() {
                    triggerZoom = zoomFunc;
                  });
                },
              );
            },
          ),
          Positioned(
            top: size.height / 12,
            left: size.width / 23,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                backgroundColor: colorScheme.secondary,
                child: Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: colorScheme.tertiaryContainer,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height / 1.6,
            right: size.width / 23,
            child: GestureDetector(
              onTap: () {
                triggerZoom?.call();
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset(Images.zoom, width: 24, height: 24),
              ),
            ),
          ),
          RouteBookingWidget(),
        ],
      ),
    );
  }

  List<String> getPolylineList(GetRouteDataModel routeData) {
    final segments = routeData.routes.first.segments;
    return segments
        .map((segment) => segment.polyline as String)
        .where((polyline) => polyline.isNotEmpty)
        .toList();
  }
}
