import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/route_model/booking_request_model.dart';
import 'package:cgc_project/routing/routes.dart';
import 'package:cgc_project/screens/booked_ride_screen/widget/booked_ride_widget.dart';
import 'package:cgc_project/util/common_method.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/route_booking_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookedRideScreen extends StatefulWidget {
  const BookedRideScreen({super.key});

  @override
  State<BookedRideScreen> createState() => _BookedRideScreenState();
}

class _BookedRideScreenState extends State<BookedRideScreen> {
  VoidCallback? triggerZoom;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _) {
        showCityLinkAlert(context, colorScheme, textTheme);
      },
      child: Scaffold(
        body: Stack(
          children: [
            BlocConsumer<RouteBloc, RouteState>(
              listenWhen:
                  (previous, current) =>
                      previous.trackingStatus != current.trackingStatus,
              listener: (context, state) {
                if (state.trackingStatus == ApiStatus.success) {
                  Navigator.pushNamed(context, RoutesName.ongoingRideScreen);
                }
              },
              builder: (context, state) {
                return RouteBookingMap(
                  image: Images.upViewBus,
                  encodedPolyLines: getPolylineList(state.bookingRequestData),
                  onMapReady: (zoomFunc) {
                    setState(() {
                      triggerZoom = zoomFunc;
                    });
                  },
                );
              },
            ),
            // Positioned(
            //   top: size.height / 10,
            //   left: size.width / 23,
            //   child: GestureDetector(
            //     onTap: () {},
            //     child: CircleAvatar(
            //       backgroundColor: colorScheme.secondary,
            //       child: Icon(
            //         Icons.menu,
            //         size: 24,
            //         color: colorScheme.tertiaryContainer,
            //       ),
            //     ),
            //   ),
            // ),
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
            BookedRideWidget(),
          ],
        ),
      ),
    );
  }

  List<String> getPolylineList(BookingRequestModel routeData) {
    final segments = routeData.segments;
    return segments
        .map((segment) => segment.polyline as String)
        .where((polyline) => polyline.isNotEmpty)
        .toList();
  }

  void showCityLinkAlert(
    BuildContext context,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Labels.cityLink,
            style: textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.primary,
            ),
          ),
          content: Text(
            Labels.doYouWantToCancel,
            style: textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w400,
              color: colorScheme.primary,
            ),
          ),
          actions: <Widget>[
            BlocListener<RouteBloc, RouteState>(
              listener: (context, state) {
                if (state.bookingStatus == ApiStatus.cancel ||
                    state.trackingStatus == ApiStatus.cancel) {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutesName.routeBookingScreen,
                  );
                } else if (state.bookingStatus == ApiStatus.failure) {
                  Navigator.of(context).pop();
                  CommonMethods.showSimpleDialog(
                    context,
                    state.error?.error?.userFriendly?.title ?? '',
                    state.error?.error?.userFriendly?.description ?? '',
                  );
                }
              },
              child: TextButton(
                child: Text(
                  Labels.cancel,
                  style: textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: colorScheme.primary,
                  ),
                ),
                onPressed: () {
                  getItInstance<RouteBloc>().add(SetInitStatus());
                  getItInstance<RouteBloc>().add(CancelRequest());
                },
              ),
            ),
            TextButton(
              child: Text(
                Labels.continueRide,
                style: textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w300,
                  color: colorScheme.primary,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                // Add your continue ride logic here
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        );
      },
    );
  }
}
