import 'package:ai_marine_engine/data/sources/dio_setup.dart';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter_test/flutter_test.dart';

DioException _exception(DioExceptionType type, {int? statusCode}) {
  final request = RequestOptions(path: '/x');
  return DioException(
    requestOptions: request,
    type: type,
    response: statusCode == null
        ? null
        : Response<dynamic>(
            requestOptions: request,
            statusCode: statusCode,
          ),
  );
}

void main() {
  group('buildDio', () {
    test('sets the polite User-Agent header per TDD §5.2.1', () {
      final dio = buildDio();
      expect(
        dio.options.headers['User-Agent'],
        'AIMarineRecommendation/1.0',
      );
      dio.close(force: true);
    });

    test('overriding userAgent is honored', () {
      final dio = buildDio(userAgent: 'Test/0.0');
      expect(dio.options.headers['User-Agent'], 'Test/0.0');
      dio.close(force: true);
    });

    test('registers a RetryInterceptor', () {
      final dio = buildDio();
      expect(
        dio.interceptors.whereType<RetryInterceptor>().length,
        1,
      );
      dio.close(force: true);
    });
  });

  group('defaultRetryEvaluator (TDD §5.8)', () {
    test('retries on connection / send / receive timeouts', () async {
      expect(
        await defaultRetryEvaluator(
          _exception(DioExceptionType.connectionTimeout),
          1,
        ),
        isTrue,
      );
      expect(
        await defaultRetryEvaluator(
          _exception(DioExceptionType.sendTimeout),
          1,
        ),
        isTrue,
      );
      expect(
        await defaultRetryEvaluator(
          _exception(DioExceptionType.receiveTimeout),
          1,
        ),
        isTrue,
      );
    });

    test('does NOT retry on connectionError (no connectivity)', () async {
      // §5.8 says: "Skip retry; mark adapter offline; rely on cache layers."
      expect(
        await defaultRetryEvaluator(
          _exception(DioExceptionType.connectionError),
          1,
        ),
        isFalse,
      );
    });

    test('retries on 5xx', () async {
      for (final status in <int>[500, 502, 503, 504]) {
        expect(
          await defaultRetryEvaluator(
            _exception(
              DioExceptionType.badResponse,
              statusCode: status,
            ),
            1,
          ),
          isTrue,
          reason: 'expected retry on HTTP $status',
        );
      }
    });

    test('retries on 429 (rate-limited; backoff respects Retry-After)',
        () async {
      expect(
        await defaultRetryEvaluator(
          _exception(DioExceptionType.badResponse, statusCode: 429),
          1,
        ),
        isTrue,
      );
    });

    test('does NOT retry on other 4xx', () async {
      for (final status in <int>[400, 401, 403, 404]) {
        expect(
          await defaultRetryEvaluator(
            _exception(
              DioExceptionType.badResponse,
              statusCode: status,
            ),
            1,
          ),
          isFalse,
          reason: 'expected NO retry on HTTP $status',
        );
      }
    });

    test('cancel and badCertificate never retry', () async {
      expect(
        await defaultRetryEvaluator(_exception(DioExceptionType.cancel), 1),
        isFalse,
      );
      expect(
        await defaultRetryEvaluator(
          _exception(DioExceptionType.badCertificate),
          1,
        ),
        isFalse,
      );
    });
  });
}
