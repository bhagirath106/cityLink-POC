import 'package:cgc_project/models/route_model/booking_accepted_model.dart';
import 'package:cgc_project/util/common_method.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:flutter/material.dart';

class BookedRideTimeline extends StatelessWidget {
  final BookingAcceptedModel bookingAcceptedData;
  const BookedRideTimeline({super.key, required this.bookingAcceptedData});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: size.height / 29,
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
              Column(
                children: [
                  SizedBox(height: size.height / 8),
                  _buildLocationTimeRow(
                    textTheme,
                    colorScheme,
                    size,
                    '${Labels.shuttleAt} ${bookingAcceptedData.segments.first.stops.last.location?.address?.trim()}',
                    '${bookingAcceptedData.segments.first.distance} ${Labels.mAway}',
                    CommonMethods.formatToAmPm(
                      bookingAcceptedData
                          .segments
                          .first
                          .stops
                          .last
                          .scheduledTime!
                          .toString(),
                    ),
                  ),
                  SizedBox(height: size.height / 6),
                  _buildLocationTimeRow(
                    textTheme,
                    colorScheme,
                    size,
                    '${Labels.youOnly} ${bookingAcceptedData.segments[1].stops.last.scheduledTime!.difference(bookingAcceptedData.segments.first.stops.first.scheduledTime!).inMinutes} ${Labels.minsAway}',
                    '${bookingAcceptedData.segments[1].distance} ${Labels.mAway}',
                    CommonMethods.formatToAmPm(
                      bookingAcceptedData.segments[1].stops.last.scheduledTime!
                          .toString(),
                    ),
                  ),
                  SizedBox(height: size.height / 9.8),
                  _buildLocationTimeRow(
                    textTheme,
                    colorScheme,
                    size,
                    'Pickup Spot at ${bookingAcceptedData.segments.last.stops.last.location?.name}',
                    '${bookingAcceptedData.segments.last.distance} ${Labels.mAway}',
                    CommonMethods.formatToAmPm(
                      bookingAcceptedData
                          .segments
                          .last
                          .stops
                          .last
                          .scheduledTime!
                          .toString(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildColumnBar(Size size, ColorScheme colorScheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dotted line
        Container(
          width: 6,
          height: size.height / 8,
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
          height: size.height / 6,
          color: colorScheme.tertiaryContainer,
          alignment: Alignment.center,
        ),
        // Bottom walking icon
        CircleAvatar(
          radius: 16,
          backgroundColor: colorScheme.tertiaryContainer.withAlpha(30),
          child: Icon(
            Icons.directions_walk,
            color: colorScheme.tertiaryContainer,
          ),
        ),

        // More dotted lines
        Container(
          width: 10,
          color: colorScheme.tertiaryContainer,
          child: Column(
            children: [
              ...List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Container(
                    height: 8,
                    width: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.secondary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 15,
          backgroundColor: colorScheme.primary,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: colorScheme.secondary),
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
                    width: size.width / 1.7,
                    child: Text(
                      location,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onTertiaryContainer,
                      ),
                    ),
                  ),
                  Text(
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
