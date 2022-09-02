// 🎯 Dart imports:
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:developer';

// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';

// 📦 Package imports:
import 'package:http/http.dart' as http;

import 'network_exception.dart';

class ApiProvider {
  final String apiBase;

  ApiProvider({
    required this.apiBase,
  });

  Future<dynamic> getWithoutBase(
    String url, {
    bool withToken = false,
    Function(int, int)? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final _url = url.replaceFirst('http', 'http');
      log('GET (Without base): $_url');
      final ans = await http.get(Uri.parse(_url),
          headers: await _getHeaders(withToken: withToken));

      return _response(ans);
    } catch (e) {
      log('Exception: $e');
      rethrow;
    }
  }

  Future<dynamic> get(
    String url, {
    bool withToken = true,
    Function(int, int)? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      log('GET: ${Uri.parse(apiBase).path}$url${queryParameters?.toString() ?? ''}');

      final route = Uri(
        scheme: 'http',
        host: Uri.parse(apiBase).host,
        path: Uri.parse(apiBase).path + url,
        queryParameters: queryParameters,
      );
      final ans = await http.get(
        route,
        headers: await _getHeaders(withToken: withToken),
      );
      return _response(ans);
    } catch (e) {
      log('Exception: $e');
      rethrow;
    }
  }

  /// body could be any type like [Map] or [String] using json.encode()
  /// dio will process both types
  Future<dynamic> post(
    String url, {
    dynamic body,
    bool withToken = true,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
  }) async {
    try {
      log('POST: $url:$body');
      final http.Response response = await http.post(
        Uri.parse(apiBase + url),
        body: body == null ? null : json.encode(body),
        headers: await _getHeaders(
          withToken: withToken,
          withContentType: true,
        ),
      );

      return _response(response);
    } catch (e) {
      log('Exception: $e');
      rethrow;
    }
  }

  Future<dynamic> postWithoutBase(
    String url, {
    dynamic body,
    bool withToken = true,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
        headers: await _getHeaders(
          withToken: withToken,
          withContentType: true,
        ),
      );
      return _response(response);
    } catch (e) {
      log('Exception: $e');
      rethrow;
    }
  }

  /// body could be any type like [Map] or [String] using json.encode()
  /// dio will process both types
  Future<dynamic> put(
    String url, {
    dynamic body,
    bool withToken = true,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final http.Response response = await http.put(
        Uri.parse(apiBase + url),
        body: json.encode(body),
        headers: await _getHeaders(
          withToken: withToken,
          withContentType: true,
        ),
      );
      return _response(response);
    } catch (e) {
      log('Exception: $e');
      rethrow;
    }
  }

  Future<dynamic> patch(
    String url, {
    dynamic body,
    bool withToken = true,
    Function(int, int)? onSendProgress,
    Function(int, int)? onReceiveProgress,
  }) async {
    try {
      log('patch: ${Uri.parse(apiBase + url)}body: ${json.encode(body)}');
      final http.Response response = await http.patch(
        Uri.parse(apiBase + url),
        body: json.encode(body),
        headers: await _getHeaders(
          withToken: withToken,
          withContentType: true,
        ),
      );
      return _response(response);
    } catch (e) {
      log('Exception: $e');
      rethrow;
    }
  }

  Future<dynamic> delete(
    String url, {
    dynamic body,
    bool withToken = true,
  }) async {
    try {
      debugPrint('DELETE: $url');
      final http.Response response = await http.delete(
        Uri.parse(apiBase + url),
        body: json.encode(body),
        headers: await _getHeaders(
          withToken: withToken,
        ),
      );
      return _response(response);
    } catch (e) {
      log('Exception: $e');
      rethrow;
    }
  }

  _decodeResponse(
    bool utf8Support,
    List<int> bytes,
  ) {
    log(utf8.decode(bytes));
    if (bytes.isEmpty) return {};

    if (utf8Support) {
      return json.decode(utf8.decode(bytes));
    } else {
      return json.decode(bytes.toString());
    }
  }

  dynamic _response(http.Response response) {
    log("API RESPONSE ----> code:${response.statusCode} - ${response.body.toString()}");

    dynamic responseMap;
    try {
      responseMap = _decodeResponse(true, response.bodyBytes);
    } catch (e) {
      responseMap = {
        'message': 'Unknown error happened parsing json response.'
      };
    }

    switch (response.statusCode) {
      case 200:
        return responseMap;
      case 201:
        return responseMap;
      case 202:
        return responseMap;
      case 203:
        return responseMap;
      case 204:
        return responseMap;
      default:
        log('Error: ${response.body}');
        throw NetworkException(
          statusCode: response.statusCode,
        );
    }
  }

  /// if request needs header
  /// first try to get header from cache
  /// if token is not saved in cache try to authenticate with api
  Future<Map<String, String>> _getHeaders({
    bool withToken = true,
    bool withContentType = true,
  }) async {
    Map<String, String> headers = {"Connection": "keep-alive"};
    if (withContentType) headers['Content-Type'] = "application/json";
    log("headers: ${headers.toString()}");

    return headers;
  }
}
