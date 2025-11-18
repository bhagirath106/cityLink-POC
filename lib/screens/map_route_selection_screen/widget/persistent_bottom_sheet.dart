import 'package:cgc_project/bloc/route/route_bloc.dart';
import 'package:cgc_project/bloc/search_location_bloc/search_location_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/search_location/set_lat_long_model.dart';
import 'package:cgc_project/routing/routes.dart';
import 'package:cgc_project/util/common_method.dart';
import 'package:cgc_project/util/constant/enum.dart';
import 'package:cgc_project/util/constant/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersistentBottomSheet extends StatelessWidget {
  final bool toggle;
  final Function(bool) onToggle;
  const PersistentBottomSheet({
    super.key,
    required this.toggle,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    bool searchSuccess = false;
    return BlocBuilder<SearchLocationBloc, SearchLocationState>(
      builder: (context, state) {
        final suggestionList = state.localSuggestionList ?? [];
        return DraggableScrollableSheet(
          initialChildSize: suggestionList.isEmpty ? 0.2 : 0.4,
          minChildSize: suggestionList.isEmpty ? 0.2 : 0.4,
          maxChildSize: 0.4,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: size.width / 23),
              decoration: BoxDecoration(
                color: colorScheme.secondary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height / 50),
                child: SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.searchScreen,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.search, color: Colors.black54),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    // state
                                    //         .setLatLongData
                                    //         ?.destination
                                    //         ?.place
                                    //         .location
                                    //         ?.address ??
                                    //     state
                                    //         .setLatLongData
                                    //         ?.destination
                                    //         ?.place
                                    //         .location
                                    //         ?.name ??
                                    Labels.destinationInitialLabel,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: size.height / 100),

                        /// Recent Locations
                        MultiBlocListener(
                          listeners: [
                            BlocListener<
                              SearchLocationBloc,
                              SearchLocationState
                            >(
                              listenWhen:
                                  (prev, curr) =>
                                      prev.status != curr.status && toggle,
                              listener: (context, state) {
                                if (state.status ==
                                    ApiStatus.getLatLongSuccess) {
                                  getItInstance<SearchLocationBloc>().add(
                                    SetPickupOrDestinationEvent(
                                      latLong: LatLongModel(
                                        value: 'end',
                                        place: state.getLatLongData!.place!,
                                      ),
                                    ),
                                  );
                                } else if (state.status == ApiStatus.navigate) {
                                  getItInstance<RouteBloc>().add(
                                    GetRouteInfo(),
                                  );
                                  searchSuccess = true;
                                  getItInstance<SearchLocationBloc>().add(
                                    OnAutoCompleteClearEvent(),
                                  );
                                }
                              },
                            ),
                            BlocListener<RouteBloc, RouteState>(
                              listenWhen:
                                  (prev, curr) =>
                                      prev.status != curr.status &&
                                      searchSuccess,
                              listener: (context, routeState) {
                                if (routeState.status == ApiStatus.failure) {
                                  final userFriendly =
                                      routeState.error?.error?.userFriendly;
                                  if (userFriendly != null) {
                                    CommonMethods.showSimpleDialog(
                                      context,
                                      userFriendly.title!,
                                      userFriendly.description!,
                                    );
                                    searchSuccess = false;
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          routeState.error?.error?.message ??
                                              Labels.somethingWentWrong,
                                        ),
                                      ),
                                    );
                                    searchSuccess = false;
                                  }
                                } else {
                                  if (routeState.status == ApiStatus.success &&
                                      searchSuccess) {
                                    Navigator.pushNamed(
                                      context,
                                      RoutesName.routeBookingScreen,
                                    );
                                    searchSuccess = false; // Reset flag
                                  }
                                }
                              },
                            ),
                          ],
                          child: SizedBox(
                            height: size.height / 3.7,
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: suggestionList.length,
                              itemBuilder: (context, index) {
                                final suggestion = suggestionList[index];
                                return ListTile(
                                  title: Text(
                                    suggestion.name ?? '',
                                    style: textTheme.bodyLarge!.copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    suggestion.address ?? '',
                                    style: textTheme.bodyMedium!.copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    onToggle(true);
                                    getItInstance<SearchLocationBloc>().add(
                                      GetLatLongEvent(
                                        suggestionData: suggestion,
                                      ),
                                    );
                                  },
                                  leading: Icon(
                                    Icons.history,
                                    color: colorScheme.primary.withAlpha(99),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (_, __) =>
                                      Divider(color: colorScheme.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
