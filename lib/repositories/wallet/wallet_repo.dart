import 'package:cgc_project/service/base_service.dart';
import 'package:cgc_project/service/local_storage_service.dart';
import 'package:cgc_project/service/urls.dart';
import 'package:dio/dio.dart';

class WalletRepository extends BaseService {
  Future<Response> getPaymentInfo() async {
    Response response;

    final String userId = await LocalStorageServices.getUserId ?? '';
    final String authToken = await LocalStorageServices.getAuthToken ?? '';

    Map<String, String> headers = {
      'X-Installation-Id': '5f2395c4-ac2c-462d-b0d2-1dd0ef0b836c',
      'X-User-Id': userId,
      'X-User-Token': authToken,
    };

    response = await makeRequest(
      baseUrl: BaseUrls.walletUrl,
      url: "${EndPoints.wallet}/$userId/wallet",
      headers: headers,
      method: HttpMethod.get,
    );

    return response;
  }
}
