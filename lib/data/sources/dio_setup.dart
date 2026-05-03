import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

/// Builds the Dio instance every NOAA adapter shares.
///
/// Wires the retry interceptor per TDD §5.8: up to three attempts with
/// exponential backoff (1s, 4s, 16s); 5xx and timeouts retry; 4xx don't
/// (except 429, which honors Retry-After via dio_smart_retry's built-in
/// handling). Network/SocketException short-circuits the retry chain so
/// the caller can fall back to cache without paying the backoff.
///
/// The base options set conservative timeouts so a stalled NOAA endpoint
/// doesn't hold the engine's score-grid loop hostage.
Dio buildDio({
  Duration connectTimeout = const Duration(seconds: 5),
  Duration receiveTimeout = const Duration(seconds: 15),
  String userAgent = 'AIMarineRecommendation/1.0',
}) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: {'User-Agent': userAgent},
    ),
  );

  dio.interceptors.add(
    RetryInterceptor(
      dio: dio,
      retries: 3,
      retryDelays: const [
        Duration(seconds: 1),
        Duration(seconds: 4),
        Duration(seconds: 16),
      ],
      retryEvaluator: defaultRetryEvaluator,
    ),
  );

  return dio;
}

/// Decides whether a failed request should be retried.
///
/// Public so tests can assert the policy directly without spinning up an
/// HTTP fake. Mirrors TDD §5.8 verbatim.
Future<bool> defaultRetryEvaluator(DioException error, int attempt) async {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return true;
    case DioExceptionType.connectionError:
      // SocketException / no-connectivity: skip retry; cache fallback wins.
      return false;
    case DioExceptionType.cancel:
      return false;
    case DioExceptionType.badCertificate:
      return false;
    case DioExceptionType.unknown:
      // Best-effort: retry transient unknowns once.
      return attempt == 1;
    case DioExceptionType.badResponse:
      final status = error.response?.statusCode;
      if (status == null) return false;
      if (status >= 500) return true;
      if (status == 429) return true; // rate-limited; backoff respects header
      return false; // other 4xx are caller errors
  }
}
