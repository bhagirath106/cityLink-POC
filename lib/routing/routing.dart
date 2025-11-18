import 'package:cgc_project/routing/routes.dart';
import 'package:cgc_project/screens/app_info_screen/view/app_info_screen.dart';
import 'package:cgc_project/screens/booked_ride_screen/view/booked_ride_screen.dart';
import 'package:cgc_project/screens/login_screen/view/login_screen.dart';
import 'package:cgc_project/screens/map_route_selection_screen/view/map_route_selection_screen.dart';
import 'package:cgc_project/screens/map_route_selection_screen/view/search_screen.dart';
import 'package:cgc_project/screens/ongoing_ride_screen/view/ongoing_ride_screen.dart';
import 'package:cgc_project/screens/payment_screen/view/payment_screen.dart';
import 'package:cgc_project/screens/route_booking_screen/view/route_booking_screen.dart';
import 'package:cgc_project/screens/signUp_screen/view/sign_up_screen.dart';
import 'package:cgc_project/screens/voucher_screen/view/voucher_screen.dart';
import 'package:cgc_project/service/local_storage_service.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Future<String> getInitialRoute() async {
    final isAuthenticate = await LocalStorageServices.getAuth;
    final isAuthToken = await LocalStorageServices.getAuth;

    final isAuth = isAuthToken != null && isAuthenticate == 'true';

    return isAuth ? RoutesName.mapRouteSelectionScreen : RoutesName.initial;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.initial:
        return MaterialPageRoute(
          builder: (_) => const AppInfoScreen(),
          settings: settings,
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
          settings: settings,
        );
      case RoutesName.signUp:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
          settings: settings,
        );
      case RoutesName.mapRouteSelectionScreen:
        return MaterialPageRoute(
          builder: (_) => MapRouteSelectionScreen(),
          settings: settings,
        );
      case RoutesName.searchScreen:
        return PageRouteBuilder(
          pageBuilder: (_, _, _) => SearchScreen(),
          settings: settings,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      case RoutesName.routeBookingScreen:
        return PageRouteBuilder(
          pageBuilder: (_, _, _) => RouteBookingScreen(),
          settings: settings,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      case RoutesName.paymentScreen:
        return MaterialPageRoute(
          builder: (_) => PaymentScreen(),
          settings: settings,
        );
      case RoutesName.voucherScreen:
        return MaterialPageRoute(
          builder: (_) => VoucherScreen(),
          settings: settings,
        );
      case RoutesName.bookedRouteScreen:
        return PageRouteBuilder(
          pageBuilder: (_, _, _) => BookedRideScreen(),
          settings: settings,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      case RoutesName.ongoingRideScreen:
        return PageRouteBuilder(
          pageBuilder: (_, _, _) => OngoingRideScreen(),
          settings: settings,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const AppInfoScreen(),
          settings: settings,
        );
    }
  }
}
