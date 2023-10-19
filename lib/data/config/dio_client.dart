import 'package:dio/dio.dart';

final dioClient = Dio()
  ..interceptors.add(AppInterceptor())
  ..options.baseUrl = "https://api.rajaongkir.com/starter";

class AppInterceptor implements Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // send token
    options.headers.addAll({
      "key": "e44ab0df69347b30971185dacfa399f4",
    });
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    handler.next(response);
  }
}