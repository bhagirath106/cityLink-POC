import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/bloc/voucher/voucher_bloc.dart';
import 'package:cgc_project/bloc/wallet/wallet_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/route_model/get_route_data.dart';
import 'package:cgc_project/routing/routes.dart';
import 'package:cgc_project/screens/route_booking_screen/widget/booking_ride_timeline.dart';
import 'package:cgc_project/util/app_messenger.dart';
import 'package:cgc_project/util/common_method.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:cgc_project/widgets/custom_button.dart';
import 'package:cgc_project/widgets/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteBookingWidget extends StatefulWidget {
  const RouteBookingWidget({super.key});

  @override
  State<RouteBookingWidget> createState() => _RouteBookingWidgetState();
}

class _RouteBookingWidgetState extends State<RouteBookingWidget> {
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
            final getData = state.getRouteData.routes.first;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    getNearestPickupMessage(getData.segments.first.stops),
                    style: textTheme.bodyMedium!.copyWith(
                      color: colorscheme.primary,
                    ),
                  ),
                ),
                SizedBox(height: size.height / 100),
                Container(
                  height: size.height / 300,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                SizedBox(height: size.height / 50),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.directions_walk,
                            size: 19,
                            color: colorscheme.onTertiaryContainer,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height / 100),
                            child: Text(
                              '${getData.segments.first.stops.last.scheduledTime!.difference(getData.segments.first.stops.first.scheduledTime!).inMinutes}',
                              style: textTheme.titleMedium!.copyWith(
                                color: colorscheme.onTertiaryContainer,
                              ),
                            ),
                          ),
                          SizedBox(width: size.width / 50),
                          Text(
                            '>',
                            style: textTheme.bodyMedium!.copyWith(
                              color: colorscheme.onTertiaryContainer,
                            ),
                          ),
                          SizedBox(width: size.width / 50),
                          Icon(
                            Icons.directions_bus,
                            size: 19,
                            color: colorscheme.onTertiaryContainer,
                          ),
                          SizedBox(width: size.width / 50),
                          Text(
                            '>',
                            style: textTheme.bodyMedium!.copyWith(
                              color: colorscheme.onTertiaryContainer,
                            ),
                          ),
                          SizedBox(width: size.width / 50),
                          Icon(
                            Icons.directions_walk,
                            size: 19,
                            color: colorscheme.onTertiaryContainer,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height / 100),
                            child: Text(
                              '${getData.segments.last.stops.last.scheduledTime!.difference(getData.segments.last.stops.first.scheduledTime!).inMinutes}',
                              style: textTheme.titleMedium!.copyWith(
                                color: colorscheme.onTertiaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '${getData.price?.currency ?? ''} ${getData.price?.amount ?? ''}',
                            style: textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w700,
                              color: colorscheme.onTertiaryContainer,
                            ),
                          ),
                          SizedBox(width: size.width / 50),
                          Icon(
                            Icons.person_2,
                            size: 19,
                            color: colorscheme.surface,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: size.height / 100),
                            child: Text(
                              '${getData.properties?.selectedTariffs.first.passengerCount ?? ''}',
                              style: textTheme.titleMedium!.copyWith(
                                color: colorscheme.onTertiaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  getReachDestinationMessage(
                    getData.segments.first.stops,
                    getData.segments.last.stops,
                  ),
                  style: textTheme.bodySmall!.copyWith(
                    color: colorscheme.onTertiaryContainer,
                  ),
                ),
              ],
            );
          },
        ),

        SizedBox(height: size.height / 50),
        _buildFooter(colorscheme),
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
      return Labels.pickUpNow;
    } else {
      return "${Labels.nearestPickupMessage} $minutes ${Labels.minsAway}";
    }
  }

  String getReachDestinationMessage(
    List<Stop> startLocations,
    List<Stop> destinationLocations,
  ) {
    if (startLocations.length < 2) return '';

    final pickupTime = startLocations.first.scheduledTime!;
    final destinationTime = destinationLocations.last.scheduledTime!;

    final duration = destinationTime.difference(pickupTime);
    final totalMinutes = duration.inMinutes;

    if (totalMinutes <= 0) {
      return Labels.destinationReachedMessage;
    } else {
      return "${Labels.youMayReachMessage} $totalMinutes ${Labels.mins}";
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
                  final getData = state.getRouteData.routes.first;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${Labels.to} ${getData.segments.last.stops.last.location?.name}',
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${'${getData.segments.last.stops.last.scheduledTime!.difference(getData.segments.first.stops.first.scheduledTime!).inMinutes}'} ${Labels.mins} . ${getData.price?.currency ?? ''} ${getData.price?.amount ?? ''}',
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
        BookingRideTimeline(),
        _buildFooter(colorScheme),
      ],
    );
  }

  Widget _buildFooter(ColorScheme colorscheme) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            BlocConsumer<VoucherBloc, VoucherState>(
              listenWhen: (old, prev) => old.status != prev.status,
              listener: (context, state) {
                if (state.status == ApiStatus.success) {
                  Navigator.pushNamed(context, RoutesName.voucherScreen);
                }
              },
              builder: (context, state) {
                return _commonRowWidgetWithTextAndIcon(
                  Labels.voucher,
                  colorscheme,
                  onTap: () {
                    if (state.status != ApiStatus.loading ||
                        state.status != ApiStatus.success) {
                      getItInstance<VoucherBloc>().add(GetVoucherHistory());
                    }
                  },
                );
              },
            ),
            Container(
              height: 30,
              width: 1,
              color: colorscheme.onTertiaryContainer.withAlpha(90),
            ),
            BlocConsumer<WalletBloc, WalletState>(
              listenWhen: (prev, curr) => prev.status != curr.status,
              listener: (context, state) {
                if (state.status == ApiStatus.success) {
                  Navigator.pushNamed(context, RoutesName.paymentScreen);
                }
              },
              builder: (context, state) {
                return _commonRowWidgetWithTextAndIcon(
                  CommonMethods.capitalizeFirstLetter(
                    state.selectedPaymentMethod ?? 'wallet',
                  ),
                  colorscheme,
                  icon: Icons.account_balance_wallet,
                  onTap: () {
                    if (state.status != ApiStatus.loading &&
                        state.status != ApiStatus.success) {
                      getItInstance<WalletBloc>().add(GetPaymentData());
                    }
                  },
                );
              },
            ),
            Container(
              height: 30,
              width: 1,
              color: colorscheme.onTertiaryContainer.withAlpha(90),
            ),
            _commonRowWidgetWithTextAndIcon(
              Labels.people,
              colorscheme,
              icon: Icons.person,
            ),
          ],
        ),
        SizedBox(height: size.height / 60),
        BlocConsumer<RouteBloc, RouteState>(
          listenWhen: (prev, curr) => prev.bookingStatus != curr.bookingStatus,
          listener: (context, state) {
            if (state.bookingStatus == ApiStatus.success) {
              Navigator.pushNamed(context, RoutesName.bookedRouteScreen);
            } else if (state.bookingStatus == ApiStatus.failure) {
              final userFriendly = state.bookingError?.error?.userFriendly;
              if (userFriendly != null) {
                CommonMethods.showSimpleDialog(
                  context,
                  userFriendly.title ?? '',
                  userFriendly.description ?? '',
                );
              }
              AppMessenger.e(
                state.bookingError?.error?.userFriendly?.description ??
                    Labels.somethingWentWrong,
              );
            }
          },
          builder: (context, state) {
            if (state.bookingStatus == ApiStatus.loading ||
                state.bookingStatus == ApiStatus.success) {
              return CustomButton(
                labels: Labels.confirmRide,
                color: colorscheme.surface.withAlpha(30),
                onPressed: () {},
              );
            } else {
              return CustomButton(
                labels: Labels.confirmRide,
                onPressed: () {
                  getItInstance<RouteBloc>().add(BookingRequest());
                },
              );
            }
          },
        ),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null
                  ? Icon(icon, color: colorscheme.surface, size: 24)
                  : Image.asset(
                    imageName ?? Images.discountImage,
                    scale: 1.4,
                    color: colorscheme.surface,
                  ),
              SizedBox(width: 8),
              SizedBox(
                width: size.width / 6,
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: colorscheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
