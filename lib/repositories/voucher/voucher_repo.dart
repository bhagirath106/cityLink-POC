import 'package:cgc_project/service/base_service.dart';
import 'package:cgc_project/service/local_storage_service.dart';
import 'package:cgc_project/service/urls.dart';
import 'package:dio/dio.dart';

class VoucherRepository extends BaseService {
  Future<Response> getVoucherHistory() async {
    Response response;

    final String userId = await LocalStorageServices.getUserId ?? '';
    final String authToken = await LocalStorageServices.getAuthToken ?? '';

    Map<String, String> headers = {
      'X-Installation-Id': '5f2395c4-ac2c-462d-b0d2-1dd0ef0b836c',
      'X-User-Id': userId,
      'X-User-Token': authToken,
    };

    response = await makeRequest(
      baseUrl: BaseUrls.passengerUrl,
      url: "${EndPoints.voucherHistory}/$userId",
      headers: headers,
      method: HttpMethod.get,
    );

    return response;
  }

  Future<Response> redeemVoucher(
    String voucherCode,
    String resourceId,
    String walletId,
    String createdBy,
  ) async {
    Response response;

    final String userId = await LocalStorageServices.getUserId ?? '';
    final String authToken = await LocalStorageServices.getAuthToken ?? '';

    Map<String, String> headers = {
      'X-Installation-Id': '5f2395c4-ac2c-462d-b0d2-1dd0ef0b836c',
      'X-User-Id': userId,
      'X-User-Token': authToken,
    };

    Map<String, dynamic> body = {
      "voucherCode": voucherCode,
      "customerResourceId": resourceId,
      "currentUtcDateTime": "2025-05-13T11:30:00",
      "userWalletId": walletId,
      "createdBy": createdBy,
    };

    response = await makeRequest(
      baseUrl: BaseUrls.passengerUrl,
      url: EndPoints.redeemVoucher,
      headers: headers,
      body: body,
      method: HttpMethod.post,
    );

    return response;
  }
}
