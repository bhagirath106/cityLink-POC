class BaseUrls {
  static const String googleApiKey = 'AIzaSyDgpbEqCAyxMbYblP1OMsshZFc1aipb2AI';
  static const String userUrl = 'https://drt-users.staging.d2di.net/';
  static const String passengerUrl =
      'https://d2d-api.staging.d2di.net/passenger/v1/';
  static const String connectUrl =
      'https://d2d-api.staging.d2di.net/connect/v0/';
  static const String walletUrl =
      'https://d2d-api.staging.d2di.net/passenger/v0/';
}

class EndPoints {
  ///urls for coach dashboard.

  static String register = '${BaseUrls.userUrl}users';
  static String signIn = '${BaseUrls.userUrl}users/sign_in';
  static String getOtp =
      '${BaseUrls.passengerUrl}otp_authentication/request_code';
  static String verifyOtp =
      '${BaseUrls.passengerUrl}otp_authentication/confirm_phone_number';
  static String autoCompletion =
      '${BaseUrls.connectUrl}autocomplete/suggestions';
  static String getLatLong =
      '${BaseUrls.connectUrl}autocomplete/details/google';
  static String routes = '${BaseUrls.connectUrl}routes';
  static String confirmRoutes = '${BaseUrls.passengerUrl}booking_requests';
  static String upcomingRides = '${BaseUrls.passengerUrl}upcoming_rides';
  static String bookingAccepted = '${BaseUrls.passengerUrl}bookings';
  static String voucherHistory =
      '${BaseUrls.passengerUrl}voucher_redemption_history';
  static String redeemVoucher = '${BaseUrls.passengerUrl}redeem-voucher';
  static String wallet = '${BaseUrls.walletUrl}users';
  static String customer = '${BaseUrls.walletUrl}id/users/me';
}
