import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/route_model/booking_accepted_model.dart';
import 'package:cgc_project/routing/routes.dart';
import 'package:cgc_project/screens/booked_ride_screen/widget/booked_ride_timeline.dart';
import 'package:cgc_project/util/common_method.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/custom_button.dart';
import 'package:cgc_project/widgets/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookedRideWidget extends StatefulWidget {
  const BookedRideWidget({super.key});

  @override
  State<BookedRideWidget> createState() => _BookedRideWidgetState();
}

class _BookedRideWidgetState extends State<BookedRideWidget> {
  final DraggableScrollableController _controller =
      DraggableScrollableController();

  bool toggle = false;

  onToggle() {
    setState(() {
      toggle = true;
    });
    _controller.animateTo(
      toggle ? 0.3 : 1, // Adjust heights as needed
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return ExpandableBottomSheet(
      initialAndMinSize: 0.3,
      controller: _controller,
      collapsedBuilder:
          (context, scrollController) => _buildCollapsedContent(
            scrollController,
            colorScheme,
            size,
            textTheme,
          ),
      expandedBuilder:
          (context, scrollController) => _buildExpandedContent(
            scrollController,
            colorScheme,
            size,
            textTheme,
          ),
    );
  }

  Widget _buildCollapsedContent(
    ScrollController scrollController,
    ColorScheme colorscheme,
    Size size,
    TextTheme textTheme,
  ) {
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.symmetric(
        vertical: size.height / 120,
        horizontal: size.width / 40,
      ),
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: size.height / 150,
            width: size.width * 0.17,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
        SizedBox(height: size.height / 60),
        BlocBuilder<RouteBloc, RouteState>(
          builder: (context, state) {
            BookingAcceptedModel bookingAcceptedData =
                state.bookingAcceptedData;
            return Column(
              children: [
                Center(
                  child: Text(
                    getNearestPickupMessage(
                      bookingAcceptedData.segments.first.stops,
                    ),
                    style: textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorscheme.onTertiaryContainer,
                    ),
                  ),
                ),
                SizedBox(height: size.height / 100),

                _buildFooter(colorscheme, size, textTheme, bookingAcceptedData),
              ],
            );
          },
        ),
      ],
    );
  }

  String getNearestPickupMessage(List<Stop> locations) {
    if (locations.length < 2) return '';

    final firstTime = locations[0].scheduledTime!;
    final secondTime = locations[1].scheduledTime!;

    final duration = secondTime.difference(firstTime);
    final minutes = duration.inMinutes;

    if (minutes <= 0) {
      return Labels.shuttleArrived;
    } else {
      return "${Labels.shuttleArriving} $minutes ${Labels.mins}";
    }
  }

  Widget _buildExpandedContent(
    ScrollController scrollController,
    ColorScheme colorScheme,
    Size size,
    TextTheme textTheme,
  ) {
    return ListView(
      controller: scrollController,
      padding: EdgeInsets.zero,
      children: [
        BlocBuilder<RouteBloc, RouteState>(
          builder: (context, state) {
            BookingAcceptedModel bookingAcceptedData =
                state.bookingAcceptedData;
            return Column(
              children: [
                Container(
                  height: 135,
                  padding: EdgeInsets.only(top: size.height / 25),
                  color: colorScheme.onSecondary,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          onToggle();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width / 20,
                          ),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: colorScheme.secondary,
                            child: Icon(
                              Icons.arrow_downward,
                              color: colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: size.width / 7),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${Labels.to} ${bookingAcceptedData.segments.last.stops.last.location?.name}',
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${bookingAcceptedData.segments.last.stops.last.scheduledTime!.difference(bookingAcceptedData.segments.first.stops.first.scheduledTime!).inMinutes} ${Labels.mins}. ${bookingAcceptedData.payment?.price?.currency} ${bookingAcceptedData.payment?.price?.amount}',
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                BookedRideTimeline(bookingAcceptedData: bookingAcceptedData),
                Padding(
                  padding: EdgeInsets.all(size.width / 30),
                  child: _buildFooter(
                    colorScheme,
                    size,
                    textTheme,
                    state.bookingAcceptedData,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildFooter(
    ColorScheme colorscheme,
    Size size,
    TextTheme textTheme,
    BookingAcceptedModel bookedAcceptedData,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: size.height / 300,
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width / 90,
            vertical: size.height / 100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.person,
                      size: 32,
                      color: colorscheme.onTertiaryContainer,
                    ),
                  ),
                  SizedBox(width: size.width / 60),
                  Padding(
                    padding: EdgeInsets.only(top: size.height / 200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookedAcceptedData.booking?.driver?.firstName ?? '',
                          style: textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorscheme.onTertiaryContainer,
                          ),
                        ),
                        Text(
                          Labels.driver,
                          style: textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: colorscheme.onTertiaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                child: Icon(
                  Icons.call,
                  size: 32,
                  color: colorscheme.tertiaryContainer,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 0.5,
          color: colorscheme.onTertiaryContainer.withAlpha(90),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bookedAcceptedData.booking?.driver?.image != null
                ? Image.network(
                  bookedAcceptedData.booking!.driver!.image!,
                  width: size.width / 4,
                  height: size.height / 17,
                  fit: BoxFit.cover,
                )
                : Image.asset(Images.cityLinkBus, width: size.width / 2),
            Container(
              margin: EdgeInsets.only(top: size.height / 100),
              padding: EdgeInsets.all(size.width / 250),
              decoration: BoxDecoration(
                color: colorscheme.onSurface,
                border: Border.all(
                  color: colorscheme.primary,
                  width: 2,
                ), // Black border
                borderRadius: BorderRadius.circular(4), // Radius 4
              ),
              child: Row(
                children: [
                  SizedBox(width: size.width / 80),
                  Text(
                    bookedAcceptedData.booking?.vehicle?.licensePlate ?? '',
                    style: textTheme.titleMedium!.copyWith(
                      letterSpacing: 3,
                      fontWeight: FontWeight.w500,
                      color: colorscheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          "${bookedAcceptedData.booking?.vehicle?.model ?? ''}-${bookedAcceptedData.booking?.vehicle?.label ?? ""}",
          style: textTheme.titleMedium!.copyWith(
            color: colorscheme.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: size.height / 100),
        CustomButton(
          labels: Labels.cancelRide,
          color: colorscheme.inverseSurface,
          textColor: colorscheme.inversePrimary,
          onPressed: () {
            showCityLinkAlert(context, colorscheme, textTheme);
          },
        ),
      ],
    );
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
