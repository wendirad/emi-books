import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Sends the Firebase App Check token with every request so the server in front
/// of Supabase can reject calls that do not come from this app.
class AppCheckHttpClient extends http.BaseClient {
  AppCheckHttpClient({
    http.Client? inner,
    Future<String?> Function()? tokenProvider,
  }) : _inner = inner ?? http.Client(),
       _tokenProvider =
           tokenProvider ?? (() => FirebaseAppCheck.instance.getToken());

  static const String headerName = 'X-Firebase-AppCheck';

  final http.Client _inner;
  final Future<String?> Function() _tokenProvider;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final String? token = await _readToken();

    if (token != null && token.isNotEmpty) {
      request.headers[headerName] = token;
    }

    return _inner.send(request);
  }

  @override
  void close() => _inner.close();

  Future<String?> _readToken() async {
    try {
      return await _tokenProvider();
    } catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace, label: 'App Check token: $e');
      return null;
    }
  }
}
