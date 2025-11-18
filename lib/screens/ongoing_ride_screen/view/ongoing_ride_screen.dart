import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/route_model/booking_accepted_model.dart';
import 'package:cgc_project/routing/routes.dart';
import 'package:cgc_project/screens/ongoing_ride_screen/widget/ongoing_ride_widget.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/route_booking_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OngoingRideScreen extends StatefulWidget {
  const OngoingRideScreen({super.key});

  @override
  State<OngoingRideScreen> createState() => _OngoingRideScreenState();
}

class _OngoingRideScreenState extends State<OngoingRideScreen> {
  VoidCallback? triggerZoom;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          children: [
            BlocConsumer<RouteBloc, RouteState>(
              listener: (context, state) {
                if (state.trackingStatus == ApiStatus.closed) {
                  showRatingDialog(
                    context,
                    size,
                    colorScheme,
                    textTheme,
                    state.trackingData?.first.stops.first.location?.name ?? '',
                    state.trackingData?.last.stops.last.location?.name ?? '',
                  );
                }
              },
              builder: (context, state) {
                return RouteBookingMap(
                  image: Images.upViewBus,
                  encodedPolyLines: getPolylineList(state.trackingData!),
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
            OngoingRideWidget(),
          ],
        ),
      ),
    );
  }

  List<String> getPolylineList(List<BookingAcceptedSegment> trackingSegment) {
    final segments = trackingSegment;
    return segments
        .map((segment) => segment.polyline as String)
        .where((polyline) => polyline.isNotEmpty)
        .toList();
  }

  void showRatingDialog(
    BuildContext context,
    Size size,
    ColorScheme colorScheme,
    TextTheme textTheme,
    String from,
    String to,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (_, _) {
            getItInstance<RouteBloc>().add(SetInitStatus());
            Navigator.pushReplacementNamed(
              context,
              RoutesName.mapRouteSelectionScreen,
            );
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    Labels.latestExperience,
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),

                  // Stars (you can make this interactive with a package or custom logic)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Icon(
                        Icons.star_border,
                        color: colorScheme.onTertiaryContainer,
                        size: 30,
                      );
                    }),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    Labels.feedbackLabel,
                    style: textTheme.titleMedium!.copyWith(
                      color: colorScheme.onTertiaryContainer,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(thickness: 1, color: colorScheme.onTertiaryContainer),

                  // Location Info
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.circle_outlined,
                            color: colorScheme.onTertiaryContainer,
                          ),
                          Container(
                            height: 8,
                            width: 4,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: colorScheme.onTertiaryContainer,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Container(
                            height: 8,
                            width: 4,
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            decoration: BoxDecoration(
                              color: colorScheme.onTertiaryContainer,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Icon(
                            Icons.circle,
                            color: colorScheme.onTertiaryContainer,
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            from,
                            style: textTheme.labelMedium!.copyWith(
                              color: colorScheme.onTertiaryContainer,
                            ),
                          ),
                          SizedBox(height: size.height / 42),
                          Text(
                            to,
                            style: textTheme.labelMedium!.copyWith(
                              color: colorScheme.onTertiaryContainer,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      // Close Icon
                      GestureDetector(
                        onTap: () {
                          getItInstance<RouteBloc>().add(SetInitStatus());
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesName.mapRouteSelectionScreen,
                          );
                        },
                        child: Icon(Icons.close, size: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
