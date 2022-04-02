import 'dart:io';
import 'package:http/http.dart' as http;
import 'config.dart';
import '../storage/storage.dart';

// To use this predefined Request
// import the module
// call Request.get/post/put/delete
// call Request.base to by pass the BASE_URL if desired

class Request {
  // TODO: implement patterns to handle http status codes
  static const List<int> SUCCESS_STATUS_CODE = [200, 201, 204];

  static const Map<String, Function> METHODS_MAP = {
    'get': http.get,
    'post': http.post,
    'put': http.put,
    'delete': http.delete
  };
  static Future<http.Response> base(String method, String path,
      {Object? body}) async {
    var url = Uri.parse(path);
    late http.Response response;
    var token = await storage.read(key: 'token');
    if (method == 'post' || method == 'put') {
      response = await METHODS_MAP[method]!(
        url,
        body: body,
        headers: {
          if (token != null) HttpHeaders.authorizationHeader: token,
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
    } else if (method == 'get' || method == 'delete') {
      response = await METHODS_MAP[method]!(
        url,
        headers: {
          if (token != null) HttpHeaders.authorizationHeader: token,
        },
      );
    }
    if (SUCCESS_STATUS_CODE.contains(response.statusCode)) {
      return response;
    }
    throw Exception(
        '$method request on $url responses with status code:${response.statusCode}');
  }

  static Future<http.Response> get(String path) {
    return base('get', '$BASE_URL$path');
  }

  static Future<http.Response> post(String path, Object body) {
    return base('post', '$BASE_URL$path', body: body);
  }

  static Future<http.Response> put(String path, Object body) {
    return base('put', '$BASE_URL$path', body: body);
  }

  static Future<http.Response> delete(String path) {
    return base('delete', '$BASE_URL$path');
  }
}
