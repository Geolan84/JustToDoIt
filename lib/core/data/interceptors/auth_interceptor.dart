import 'package:dio/dio.dart';

/// Auth interceptor for http client.
class AuthInterceptor extends Interceptor {
  /// Auth token.
  final String token;

  /// Constructor of [AuthInterceptor].
  AuthInterceptor({required this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $token';
    super.onRequest(options, handler);
  }
}
