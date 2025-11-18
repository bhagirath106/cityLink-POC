import 'package:cgc_project/models/search_location/get_lat_long_model.dart';
import 'package:cgc_project/service/base_service.dart';
import 'package:cgc_project/service/urls.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class AutoCompletionLocationRepository extends BaseService {
  Future<Response> locationSearch(String location, String session) async {
    Response response;

    Map<String, String> headers = {
      'X-Installation-Id': '5f2395c4-ac2c-462d-b0d2-1dd0ef0b836c',
    };

    Map<String, dynamic> queryParameters = {
      "query": location,
      "session": session,
    };

    response = await makeRequest(
      baseUrl: BaseUrls.connectUrl,
      url: EndPoints.autoCompletion,
      headers: headers,
      queryParameters: queryParameters,
      method: HttpMethod.get,
    );

    return response;
  }

  Future<Response> getLatLong(String locationId, String session) async {
    Response response;

    Map<String, String> headers = {
      'X-Installation-Id': '5f2395c4-ac2c-462d-b0d2-1dd0ef0b836c',
    };

    Map<String, dynamic> queryParameters = {"session": session};

    response = await makeRequest(
      baseUrl: BaseUrls.connectUrl,
      url: '${EndPoints.getLatLong}/$locationId',
      headers: headers,
      queryParameters: queryParameters,
      method: HttpMethod.get,
    );

    return response;
  }

  static Future<LocationModel> getCurrentLocation() async {
    loc.Location location = loc.Location();
    final getLoc = await location.getLocation();

    final placeMarks = await placemarkFromCoordinates(
      getLoc.latitude!,
      getLoc.longitude!,
    );

    final placeMark = placeMarks.first;

    return LocationModel(
      lat: getLoc.latitude,
      lng: getLoc.longitude,
      name: placeMark.name,
      address:
          '${placeMark.street}, ${placeMark.locality}, ${placeMark.country}',
    );
  }
}
