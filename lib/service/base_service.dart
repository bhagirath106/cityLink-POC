import 'package:dio/dio.dart';

enum HttpMethod { get, post, delete, put, patch, download }

class BaseService {
  final Dio dio;

  BaseService() : dio = Dio();

  Future<dynamic> makeRequest<T>({
    required String url,
    Map<String, dynamic>? headers,
    required String baseUrl,
    String? check,
    required HttpMethod method,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Options? options,
    dynamic savePath,
    String? contentType,
    String? authToken,
    CancelToken? token,
  }) async {
    if (check == "interceptors") {
      dio.interceptors.add(
        QueuedInterceptorsWrapper(
          /// Adds CSRF token to headers, if it exists
          onRequest: (requestOptions, handler) {
            Future.delayed(const Duration(seconds: 70), () {});
          },
        ),
      );
    }
    dio.options.baseUrl = baseUrl;
    if (headers != null) {
      dio.options.headers = headers;
    }
    dio.options.connectTimeout = Duration(seconds: 10);
    dio.options.receiveTimeout = Duration(seconds: 10);
    dio.options.contentType = contentType ?? 'application/json';
    dio.options.headers['X-Organization-Id'] =
        headers?['X-Organization-Id'] ?? 'da62a339-36b6-4550-b404-fd0d6c9a1158';
    Response<dynamic> response;

    switch (method) {
      case HttpMethod.get:
        if (queryParameters != null && queryParameters.isNotEmpty) {
          response = await dio.get(url, queryParameters: queryParameters);
          return response;
        }
        response = await dio.get<T>(
          url,
          cancelToken: token,
          data: body,
          options: Options(
            headers: {'Bearer': "${dio.options.headers['Authorization']}"},
          ),
        );
        return response;
      case HttpMethod.post:
        response = await dio.post<T>(
          url,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );

        break;
      case HttpMethod.delete:
        response = await dio.delete<T>(
          url,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case HttpMethod.put:
        response = await dio.put<T>(
          url,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case HttpMethod.patch:
        response = await dio.patch<T>(
          url,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        break;
      case HttpMethod.download:
        response = await dio.download(
          url,
          savePath,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
        break;
    }
    return response;
  }

  void close() {
    dio.close();
  }
}
