import 'package:cgc_project/models/authentication_model/sign_up_credential_model.dart';
import 'package:cgc_project/service/base_service.dart';
import 'package:cgc_project/service/local_storage_service.dart';
import 'package:cgc_project/service/urls.dart';
import 'package:dio/dio.dart';

class AuthenticationRepository extends BaseService {
  Future<Response> registerAuthentication(
    SignUpCredentialModel signUpCredentialData,
  ) async {
    Response response;
    List<String> nameParts = signUpCredentialData.name?.split(' ') ?? [];
    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    String lastName = nameParts.length > 1 ? nameParts[1] : '';
    Map<String, dynamic> requestBody = {
      "user": {
        "email": signUpCredentialData.email,
        "password": signUpCredentialData.password,
        "first_name": firstName,
        "last_name": lastName,
        "confirmed_phone_number": signUpCredentialData.number,
      },
      "skip_invitation_code": true,
    };

    Map<String, String> headers = {
      'X-Api-Key':
          'kEzgwZnPyMFyqcXYQGktKXxnbCVnUK38NCQCPCeXWLYrh9mxrEmGqxw7jCPPtNUF',
      'X-Application-Id': '6b223ab5-af8c-4505-9ee6-7efae22c26e9',
    };

    response = await makeRequest(
      baseUrl: BaseUrls.userUrl,
      url: EndPoints.register,
      body: requestBody,
      headers: headers,
      method: HttpMethod.post,
    );

    return response;
  }

  Future<Response> loginAuthentication(
    SignUpCredentialModel signUpCredentialData,
  ) async {
    Response response;
    Map<String, dynamic> requestBody = {
      "user": {
        "email": signUpCredentialData.email,
        "password": signUpCredentialData.password,
      },
    };

    Map<String, String> headers = {
      'X-Api-Key':
          'kEzgwZnPyMFyqcXYQGktKXxnbCVnUK38NCQCPCeXWLYrh9mxrEmGqxw7jCPPtNUF',
      'X-Application-Id': '6b223ab5-af8c-4505-9ee6-7efae22c26e9',
    };

    response = await makeRequest(
      baseUrl: BaseUrls.userUrl,
      url: EndPoints.signIn,
      body: requestBody,
      headers: headers,
      method: HttpMethod.post,
    );

    return response;
  }

  Future<Response> getOtpAuthentication(String number) async {
    Response response;

    Map<String, dynamic> requestBody = {"user_phone_number": number};

    Map<String, String> headers = {
      'X-Installation-Id': '5f2395c4-ac2c-462d-b0d2-1dd0ef0b836c',
    };
    response = await makeRequest(
      baseUrl: BaseUrls.passengerUrl,
      url: EndPoints.getOtp,
      body: requestBody,
      headers: headers,
      method: HttpMethod.post,
    );

    return response;
  }

  Future<Response> verifyOtpAuthentication(String number, String otp) async {
    Response response;
    Map<String, dynamic> requestBody = {
      "user_phone_number": number,
      "verification_code": otp,
    };
    Map<String, String> headers = {
      'X-Installation-Id': '5f2395c4-ac2c-462d-b0d2-1dd0ef0b836c',
    };

    response = await makeRequest(
      baseUrl: BaseUrls.passengerUrl,
      url: EndPoints.verifyOtp,
      body: requestBody,
      headers: headers,
      method: HttpMethod.post,
    );

    return response;
  }

  Future<Response> getCustomerDetail() async {
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
      url: EndPoints.customer,
      headers: headers,
      method: HttpMethod.get,
    );

    return response;
  }
}
