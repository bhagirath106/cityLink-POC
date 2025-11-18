import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/route_model/booking_accepted_model.dart';
import 'package:cgc_project/screens/ongoing_ride_screen/widget/ongoing_ride_timeline.dart';
import 'package:cgc_project/util/common_method.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OngoingRideWidget extends StatefulWidget {
  const OngoingRideWidget({super.key});

  @override
  State<OngoingRideWidget> createState() => _OngoingRideWidgetState();
}

class _OngoingRideWidgetState extends State<OngoingRideWidget> {
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
        horizontal: size.width / 26,
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
            return Center(
              child: Text(
                '${Labels.dropOffIn} ${state.trackingData?.last.stops.last.scheduledTime?.difference(state.trackingData!.first.stops.first.scheduledTime!).inMinutes} ${Labels.mins}',
                style: textTheme.bodyMedium!.copyWith(
                  color: colorscheme.primary,
                ),
              ),
            );
          },
        ),
        SizedBox(height: size.height / 100),
        Divider(
          thickness: 1,
          color: colorscheme.onTertiaryContainer.withAlpha(80),
        ),
        SizedBox(height: size.height / 150),
        _buildRowBar(size, colorscheme),
        BlocBuilder<RouteBloc, RouteState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  CommonMethods.formatToAmPm(
                    state.trackingData!.first.stops.first.scheduledTime
                        .toString(),
                  ),
                  style: textTheme.titleMedium!.copyWith(
                    color: colorscheme.onTertiaryContainer,
                  ),
                ),
                Text(
                  CommonMethods.formatToAmPm(
                    state.trackingData!.last.stops.last.scheduledTime
                        .toString(),
                  ),
                  style: textTheme.titleMedium!.copyWith(
                    color: colorscheme.onTertiaryContainer,
                  ),
                ),
              ],
            );
          },
        ),
        SizedBox(height: size.height / 150),
        _buildFooter(colorscheme, textTheme),
      ],
    );
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
                  padding: EdgeInsets.symmetric(horizontal: size.width / 20),
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
              BlocBuilder<RouteBloc, RouteState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${Labels.to} ${state.trackingData?.last.stops.last.location?.name ?? state.trackingData?.last.stops.last.location?.address ?? ''}',
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${state.trackingData?.last.stops.last.scheduledTime?.difference(state.trackingData!.first.stops.first.scheduledTime!).inMinutes} ${Labels.mins} . ${state.bookingAcceptedData.booking?.price?.currency ?? ''} ${state.bookingAcceptedData.booking?.price?.amount ?? ''}',
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(width: size.width / 50),
        OngoingTransportationTimeline(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width / 26),
          child: _buildFooter(colorScheme, textTheme),
        ),
      ],
    );
  }

  Widget _buildFooter(ColorScheme colorscheme, TextTheme textTheme) {
    Size size = MediaQuery.of(context).size;
    BookingAcceptedModel bookingAcceptedData =
        getItInstance<RouteBloc>().state.bookingAcceptedData;
    return Column(
      children: [
        Divider(
          thickness: 1,
          color: colorscheme.onTertiaryContainer.withAlpha(80),
        ),
        SizedBox(height: size.height / 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, color: colorscheme.surfaceContainer),
            Text(
              "${Labels.youPaid} ${bookingAcceptedData.booking?.price?.currency ?? ''} ${bookingAcceptedData.booking?.price?.amount ?? 100}",
              style: textTheme.titleMedium!.copyWith(
                color: colorscheme.surfaceContainer,
              ),
            ),
          ],
        ),
        SizedBox(height: size.height / 100),
        Divider(
          thickness: 1,
          color: colorscheme.onTertiaryContainer.withAlpha(80),
        ),
        SizedBox(height: size.height / 150),
        Row(
          children: [
            _commonRowWidgetWithTextAndIcon(
              Labels.share,
              colorscheme,
              imageName: Images.share,
              onTap: () {},
            ),
            _commonRowWidgetWithTextAndIcon(
              Labels.support,
              colorscheme,
              icon: Icons.contact_support,
              onTap: () {},
            ),
            _commonRowWidgetWithTextAndIcon(
              Labels.safety,
              colorscheme,
              imageName: Images.safety,
            ),
          ],
        ),
        SizedBox(height: size.height / 100),
      ],
    );
  }

  Widget _commonRowWidgetWithTextAndIcon(
    String text,
    ColorScheme colorscheme, {
    IconData? icon,
    String? imageName,
    VoidCallback? onTap,
  }) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: colorscheme.tertiaryContainer.withAlpha(30),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          margin: EdgeInsets.symmetric(horizontal: size.width / 60),
          padding: EdgeInsets.symmetric(vertical: size.height / 200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Icon(icon, color: colorscheme.onTertiaryContainer, size: 24)
                  : Image.asset(
                    imageName ?? Images.discountImage,
                    scale: 1,
                    color: colorscheme.onTertiaryContainer,
                  ),
              SizedBox(width: 8),
              Text(text, style: TextStyle(color: colorscheme.primary)),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildRowBar(Size size, ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
          width: size.height / 7,
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
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
          width: size.height / 6,
          height: 8,
          color: colorScheme.primary,
          alignment: Alignment.center,
        ),
        // Bottom walking icon
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: colorScheme.primary,
            border: Border.all(width: 7),
          ),
          child: CircleAvatar(backgroundColor: colorScheme.secondary),
        ),
      ],
    );
  }
}
