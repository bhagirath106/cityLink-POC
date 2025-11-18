import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/util/common_method.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OngoingTransportationTimeline extends StatelessWidget {
  const OngoingTransportationTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height / 20,
        horizontal: size.width / 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildColumnBar(size, colorScheme),
              SizedBox(width: 20),
              BlocBuilder<RouteBloc, RouteState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      _buildLocationTimeRow(
                        textTheme,
                        colorScheme,
                        size,
                        '${Labels.pickSpot} ${state.trackingData?.first.stops.first.location?.name ?? ''}',
                        '',
                        CommonMethods.formatToAmPm(
                          state.trackingData?.first.stops.first.scheduledTime
                                  .toString() ??
                              '',
                        ),
                      ),
                      SizedBox(height: size.height / 4.2),
                      _buildLocationTimeRow(
                        textTheme,
                        colorScheme,
                        size,
                        '${Labels.shuttleAt} ${state.trackingData?.first.stops.last.scheduledTime!.difference(state.trackingData!.first.stops.first.scheduledTime!).inMinutes} ${Labels.mins}',
                        'Live',
                        CommonMethods.formatToAmPm(
                          state.trackingData?.first.stops.last.scheduledTime
                                  .toString() ??
                              '',
                        ),
                      ),
                      SizedBox(height: size.height / 10),
                      _buildLocationTimeRow(
                        textTheme,
                        colorScheme,
                        size,
                        '${Labels.dropOff} ${state.trackingData?.last.stops.first.location?.name ?? state.trackingData?.last.stops.first.location?.address ?? ''}',
                        '',
                        CommonMethods.formatToAmPm(
                          state.trackingData!.last.stops.first.scheduledTime
                              .toString(),
                        ),
                      ),
                      SizedBox(height: size.height / 14),
                      _buildLocationTimeRow(
                        textTheme,
                        colorScheme,
                        size,
                        '${Labels.walkTo} ${state.trackingData?.last.stops.last.location?.name ?? state.trackingData?.last.stops.last.location?.address ?? ''}',
                        '${state.trackingData?.first.distance}${Labels.minsAway} · 8 min',
                        CommonMethods.formatToAmPm(
                          state.trackingData?.last.stops.last.scheduledTime
                                  .toString() ??
                              '',
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildColumnBar(Size size, ColorScheme colorScheme) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: colorScheme.primary,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: colorScheme.secondary),
          ),
        ),
        // Dotted line
        Container(
          width: 6,
          height: size.height / 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(
                  105,
                  115,
                  130,
                  0.3,
                ), // Your original gradient colors
                Color.fromRGBO(105, 115, 130, 1.0),
              ],
            ),
          ),
        ),

        // Bus icon
        CircleAvatar(
          radius: 16,
          backgroundColor: colorScheme.tertiaryContainer.withAlpha(30),
          child: Icon(
            Icons.directions_bus,
            color: colorScheme.tertiaryContainer,
          ),
        ),

        // Thick route line
        Container(
          width: 10,
          height: size.height / 10,
          color: colorScheme.primary,
          alignment: Alignment.center,
        ),

        Container(
          width: 23,
          height: 23,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            border: Border.all(width: 7),
          ),
          child: CircleAvatar(backgroundColor: colorScheme.secondary),
        ),
        // More dotted lines
        Column(
          children: [
            ...List.generate(
              5,
              (index) => Container(
                height: 8,
                width: 4,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: colorScheme.onTertiaryContainer,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 16,
          backgroundColor: colorScheme.onTertiaryContainer.withAlpha(30),
          child: Icon(
            Icons.directions_walk,
            size: 30,
            color: colorScheme.onTertiaryContainer,
          ),
        ),
      ],
    );
  }

  SizedBox _buildLocationTimeRow(
    TextTheme textTheme,
    ColorScheme colorScheme,
    Size size,
    String location,
    String distance,
    String time,
  ) {
    return SizedBox(
      width: size.width / 1.3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onTertiaryContainer,
                    ),
                  ),
                  (distance == 'Live')
                      ? Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width / 30,
                          vertical: size.height / 300,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.tertiaryContainer.withAlpha(30),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          distance,
                          style: textTheme.titleMedium!.copyWith(
                            color: colorScheme.tertiaryContainer,
                          ),
                        ),
                      )
                      : Text(
                        distance,
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: colorScheme.onTertiaryContainer,
                        ),
                      ),
                ],
              ),
              Text(
                time,
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onTertiaryContainer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
