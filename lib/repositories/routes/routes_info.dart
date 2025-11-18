import 'package:cgc_project/models/route_model/get_route_data.dart';
import 'package:cgc_project/models/search_location/set_lat_long_model.dart';
import 'package:cgc_project/service/base_service.dart';
import 'package:cgc_project/service/local_storage_service.dart';
import 'package:cgc_project/service/urls.dart';
import 'package:dio/dio.dart';

class RoutesInfoRepository extends BaseService {
  Future<Response> getRoutesInfo(SetLatLongModel setLatLongData) async {
    Response response;

    Map<String, String> headers = {
      'X-Installation-Id': '5f2395c4-ac2c-462d-b0d2-1dd0ef0b836c',
    };
    DateTime now = DateTime.now(); // local time
    String isoString =
        now
            .subtract(Duration(hours: 5, minutes: 30))
            .toIso8601String(); //utc timezone according to kuwait

    Map<String, dynamic> queryParameters = {
      "from":
          "${setLatLongData.pickup?.place.location!.lat},${setLatLongData.pickup?.place.location!.lng}",
      "to":
          "${setLatLongData.destination?.place.location!.lat},${setLatLongData.destination?.place.location!.lng}",
      "from_address": setLatLongData.pickup?.place.location!.address,
      "to_address": setLatLongData.destination?.place.location!.address,
      "from_name": setLatLongData.pickup?.place.location!.name,
      "to_name": setLatLongData.destination?.place.location!.name,
      "at": isoString,
      "by": "departure",
      "active_payment_method_type": "credit_card",
    };

    response = await makeRequest(
      baseUrl: BaseUrls.connectUrl,
      url: EndPoints.routes,
      headers: headers,
      queryParameters: queryParameters,
      method: HttpMethod.get,
    );

    return response;
  }

  Future<Response> confirmBooking(GetRouteDataModel getRouteData) async {
    Response response;

    String? email = await LocalStorageServices.getEmailId;
    String? authToken = await LocalStorageServices.getAuthToken;

    Map<String, String> headers = {
      'X-Installation-Id': '5f2395c4-ac2c-462d-b0d2-1dd0ef0b836c',
      'X-User-Email': email ?? '',
      'X-User-Token': authToken ?? '',
    };
    final getData = getRouteData.routes.first;
    final teriff =
        getData
            .properties
            ?.bookingObject
            ?.tariffs
            ?.the7B2E50E2298B449B8Ae18Ea629Dce83C;
    final fromLocation = getData.segments.first.stops.first.location;
    final toLocation = getData.segments.last.stops.last.location;
    Map<String, dynamic> body = {
      "by": "departure",
      "tariffs": {"7b2e50e2-298b-449b-8ae1-8ea629dce83c": teriff},
      "from": {
        "lng": fromLocation?.lng,
        "address": fromLocation?.address,
        "lat": fromLocation?.lat,
        "name": fromLocation?.name,
      },
      "to": {
        "lng": toLocation?.lng,
        "address": toLocation?.address,
        "lat": toLocation?.lat,
        "name": toLocation?.name,
      },
      "callable_at": [
        {"service": "twilio"},
      ],
      "bookable_accessibility_options": {},
    };

    response = await makeRequest(
      baseUrl: BaseUrls.passengerUrl,
      url: EndPoints.confirmRoutes,
      headers: headers,
      body: body,
      method: HttpMethod.post,
    );

    return response;
  }

  Future<Response> upcomingRides() async {
    Response response;

    String? email = await LocalStorageServices.getEmailId;
    String? authToken = await LocalStorageServices.getAuthToken;

    Map<String, String> headers = {
      'X-Installation-Id': '5f2395c4-ac2c-462d-b0d2-1dd0ef0b836c',
      'X-User-Email': email ?? '',
      'X-User-Token': authToken ?? '',
    };

    Map<String, String> queryParameter = {
      "include": "cancelled,rejected,reservation_expired,reservation_rejected",
    };

    response = await makeRequest(
      baseUrl: BaseUrls.passengerUrl,
      url: EndPoints.upcomingRides,
      headers: headers,
      queryParameters: queryParameter,
      method: HttpMethod.get,
    );

    return response;
  }

  Future<Response> bookingAccepted(String id) async {
    Response response;

    String? email = await LocalStorageServices.getEmailId;
    String? authToken = await LocalStorageServices.getAuthToken;

    Map<String, String> headers = {
      'X-Installation-Id': '5f2395c4-ac2c-462d-b0d2-1dd0ef0b836c',
      'X-User-Email': email ?? '',
      'X-User-Token': authToken ?? '',
    };

    response = await makeRequest(
      baseUrl: BaseUrls.passengerUrl,
      url: "${EndPoints.bookingAccepted}/$id",
      headers: headers,
      method: HttpMethod.get,
    );

    return response;
  }

  Future<Response> cancelRequest(String id) async {
    Response response;

    String? email = await LocalStorageServices.getEmailId;
    String? authToken = await LocalStorageServices.getAuthToken;

    Map<String, String> headers = {
      'X-Installation-Id': '5f2395c4-ac2c-462d-b0d2-1dd0ef0b836c',
      'X-User-Email': email ?? '',
      'X-User-Token': authToken ?? '',
    };

    response = await makeRequest(
      baseUrl: BaseUrls.passengerUrl,
      url: "${EndPoints.bookingAccepted}/$id/cancellation",
      headers: headers,
      method: HttpMethod.patch,
    );

    return response;
  }
}
