import 'package:cgc_project/bloc/search_location_bloc/search_location_bloc.dart';
import 'package:cgc_project/bloc/signIn_bloc/sign_in_bloc.dart';
import 'package:cgc_project/di/di.dart';
import 'package:cgc_project/models/search_location/set_lat_long_model.dart';
import 'package:cgc_project/screens/map_route_selection_screen/widget/google_map_widget.dart';
import 'package:cgc_project/screens/map_route_selection_screen/widget/persistent_bottom_sheet.dart';
import 'package:cgc_project/util/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapRouteSelectionScreen extends StatefulWidget {
  const MapRouteSelectionScreen({super.key});

  @override
  State<MapRouteSelectionScreen> createState() =>
      _MapRouteSelectionScreenState();
}

class _MapRouteSelectionScreenState extends State<MapRouteSelectionScreen> {
  LatLongModel? pickUp;
  LatLongModel? destination;
  VoidCallback? triggerZoom;
  bool toggle = false;

  @override
  void initState() {
    onToggle(false);
    getItInstance<SignInBloc>().add(CustomerDetail());
    getItInstance<SearchLocationBloc>().add(GetCurrentLocation());
    super.initState();
  }

  void onToggle(bool isToggle) {
    setState(() {
      toggle = isToggle;
    });
  }

  @override
  void didChangeDependencies() {
    try {
      getItInstance<SearchLocationBloc>().add(GetLocalList());
      onToggle(false);
    } catch (e) {
      rethrow;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          GoogleMapWidget(
            onMapReady: (zoomFunc) {
              setState(() {
                triggerZoom = zoomFunc; // ✅ Store it when map is ready
              });
            },
          ),
          // Positioned(
          //   top: size.height / 10,
          //   left: size.width / 23,
          //   right: size.width / 23,
          //   child: Container(
          //     width: double.infinity,
          //     padding: EdgeInsets.symmetric(
          //       horizontal: size.width / 80,
          //       vertical:
          //           12, // Adjust vertical padding to look like TextFormField
          //     ),
          //     decoration: BoxDecoration(
          //       color: colorScheme.secondary,
          //       borderRadius: BorderRadius.all(Radius.circular(12.0)),
          //       border: Border.all(color: colorScheme.secondary),
          //     ),
          //     child: Row(
          //       children: [
          //         Icon(Icons.menu, color: colorScheme.primary, size: 24),
          //         const SizedBox(width: 10),
          //         Expanded(
          //           child: GestureDetector(
          //             onTap: () {
          //               Navigator.pushNamed(context, RoutesName.searchScreen);
          //             },
          //             child:
          //                 BlocBuilder<SearchLocationBloc, SearchLocationState>(
          //                   builder: (context, state) {
          //                     return Text(
          //                       state
          //                               .setLatLongData
          //                               ?.pickup
          //                               ?.place
          //                               .location
          //                               ?.address ??
          //                           state
          //                               .setLatLongData
          //                               ?.pickup
          //                               ?.place
          //                               .location
          //                               ?.name ??
          //                           state.locationData?.address ??
          //                           Labels.searchLocation, // Placeholder text
          //                       style: TextStyle(
          //                         overflow: TextOverflow.ellipsis,
          //                         color: Colors.grey[600],
          //                         fontSize: 16,
          //                       ),
          //                     );
          //                   },
          //                 ),
          //           ),
          //         ),
          //         Icon(
          //           Icons.favorite_border,
          //           color: colorScheme.primary,
          //           size: 24,
          //         ),
          //         const SizedBox(width: 6),
          //       ],
          //     ),
          //   ),
          // ),
          BlocBuilder<SearchLocationBloc, SearchLocationState>(
            builder: (context, state) {
              final suggestionList = state.localSuggestionList ?? [];
              return Positioned(
                top:
                    suggestionList.isEmpty
                        ? size.height / 1.36
                        : size.height / 1.9,
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
              );
            },
          ),

          /// Persistent Bottom Sheet
          PersistentBottomSheet(toggle: toggle, onToggle: onToggle),
        ],
      ),
    );
  }
}
