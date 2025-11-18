import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingRideTimeline extends StatelessWidget {
  const BookingRideTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height / 14,
        horizontal: size.width / 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildColumnBar(size),
              SizedBox(width: 20),
              BlocBuilder<RouteBloc, RouteState>(
                builder: (context, state) {
                  final getData = state.getRouteData.routes.first;
                  return Column(
                    children: [
                      _buildLocationTimeRow(
                        textTheme,
                        colorScheme,
                        size,
                        '${Labels.walkTo} ${getData.segments.first.stops.last.location?.name}',
                        '${'${getData.segments.first.stops.last.scheduledTime!.difference(getData.segments.first.stops.first.scheduledTime!).inMinutes}'} ${Labels.mins}',
                        formatToAmPm(
                          getData.segments.first.stops.first.scheduledTime!
                              .toString(),
                        ),
                      ),
                      SizedBox(height: size.height / 9),
                      SizedBox(
                        height: size.height / 6.5,
                        child: _buildLocationTimeRow(
                          textTheme,
                          colorScheme,
                          size,
                          '${Labels.boardThe} ${getData.segments[1].name}',
                          '${Labels.approx} ${'${getData.segments[1].stops.last.scheduledTime!.difference(getData.segments[1].stops.first.scheduledTime!).inMinutes}'} ${Labels.minsRide}',
                          formatToAmPm(
                            getData.segments.first.stops.last.scheduledTime!
                                .toString(),
                          ),
                          // nextStop: 'Next at 10:15 am',
                          // noOfTime: '3-4 stops usually',
                        ),
                      ),
                      SizedBox(height: size.height / 18),
                      _buildLocationTimeRow(
                        textTheme,
                        colorScheme,
                        size,
                        '${Labels.dropOff} ${getData.segments.last.stops.first.location?.name}',
                        '',
                        formatToAmPm(
                          getData.segments.last.stops.first.scheduledTime!
                              .toString(),
                        ),
                      ),
                      SizedBox(height: size.height / 12),
                      _buildLocationTimeRow(
                        textTheme,
                        colorScheme,
                        size,
                        '${Labels.walkTo} ${getData.segments.last.stops.last.location?.name}',
                        '${'${getData.segments.last.stops.last.scheduledTime!.difference(getData.segments.last.stops.first.scheduledTime!).inMinutes}'} ${Labels.mins}',
                        formatToAmPm(
                          getData.segments.last.stops.last.scheduledTime!
                              .toString(),
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

  String formatToAmPm(String utcDateString) {
    final dateTime =
        DateTime.parse(utcDateString).toLocal(); // Convert to local time
    final formatted = DateFormat('hh:mm a').format(dateTime); // e.g., 08:58 AM
    return formatted;
  }

  Column buildColumnBar(Size size) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Top walking icon
        CircleAvatar(
          minRadius: 16,
          backgroundColor: Colors.grey.shade200,
          child: Icon(Icons.directions_walk, color: Colors.grey.shade800),
        ),

        // Dotted line
        ...List.generate(
          6,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              height: 8,
              width: 4,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),

        // Bus icon
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey.shade200,
          child: Icon(Icons.directions_bus, color: Colors.grey.shade800),
        ),

        // Thick route line
        Container(
          width: 8,
          height: size.height / 6,
          color: Colors.grey.shade800,
          alignment: Alignment.center,
        ),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.grey.shade800, width: 7),
          ),
          child: CircleAvatar(backgroundColor: Colors.white),
        ),

        // More dotted lines
        ...List.generate(
          6,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              height: 8,
              width: 4,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),

        // Bottom walking icon
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey.shade200,
          child: Icon(Icons.directions_walk, color: Colors.grey.shade800),
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
    String time, {
    String? nextStop,
    String? noOfTime,
  }) {
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
                  SizedBox(
                    width: size.width / 1.63,
                    child: Text(
                      location,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                  Text(
                    distance,
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              Text(
                time,
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          if (nextStop != null)
            subtitleRowWidget(
              size,
              colorScheme,
              textTheme,
              nextStop,
              Icons.access_time_filled,
            ),

          if (noOfTime != null)
            subtitleRowWidget(
              size,
              colorScheme,
              textTheme,
              noOfTime,
              Icons.stop_circle,
            ),
        ],
      ),
    );
  }

  Padding subtitleRowWidget(
    Size size,
    ColorScheme colorScheme,
    TextTheme textTheme,
    String nextStop,
    IconData? icon,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: size.height / 50, left: size.height / 40),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: colorScheme.primary.withAlpha(90)),
              SizedBox(width: size.width / 70),
              Text(
                nextStop,
                style: textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: colorScheme.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height / 80),
          Container(
            height: 1,
            width: size.width / 1.2,
            color: colorScheme.primary.withAlpha(90),
          ),
        ],
      ),
    );
  }
}
