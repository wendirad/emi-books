// ignore_for_file: directives_ordering
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:emi_books/src/core/utils/utils.dart';

void main() {
  late Map<String, String> sentHeaders;
  late MockClient inner;

  setUp(() {
    sentHeaders = {};
    inner = MockClient((request) async {
      sentHeaders = request.headers;
      return http.Response('ok', 200);
    });
  });

  test('adds the App Check token header', () async {
    final client = AppCheckHttpClient(
      inner: inner,
      tokenProvider: () async => 'token-1',
    );

    final response = await client.get(Uri.parse('https://example.com'));

    expect(response.statusCode, 200);
    expect(sentHeaders[AppCheckHttpClient.headerName], 'token-1');
  });

  test('reads a fresh token for every request', () async {
    var calls = 0;
    final client = AppCheckHttpClient(
      inner: inner,
      tokenProvider: () async => 'token-${++calls}',
    );

    await client.get(Uri.parse('https://example.com'));
    await client.get(Uri.parse('https://example.com'));

    expect(sentHeaders[AppCheckHttpClient.headerName], 'token-2');
  });

  test('sends the request without the header when the token is null', () async {
    final client = AppCheckHttpClient(
      inner: inner,
      tokenProvider: () async => null,
    );

    final response = await client.get(Uri.parse('https://example.com'));

    expect(response.statusCode, 200);
    expect(sentHeaders.containsKey(AppCheckHttpClient.headerName), isFalse);
  });

  test('does not throw when fetching the token fails', () async {
    final client = AppCheckHttpClient(
      inner: inner,
      tokenProvider: () async => throw Exception('no token'),
    );

    final response = await client.get(Uri.parse('https://example.com'));

    expect(response.statusCode, 200);
    expect(sentHeaders.containsKey(AppCheckHttpClient.headerName), isFalse);
  });
}
