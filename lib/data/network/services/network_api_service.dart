import 'dart:convert';
import 'dart:io';

import 'package:base_flutter/data/models/app_exception.dart';
import 'package:base_flutter/data/network/api_response.dart';
import 'package:base_flutter/data/network/services/base_api_service.dart';
import 'package:base_flutter/helpers/mixin/auth_mixin.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService with AuthMixin {
  @override
  Future getResponse(String endPoint,
      {Map<String, String>? queryString}) async {
    dynamic responseJson;
    var token = await getAuthToken();

    var url = Uri.https(baseUrl, "/api/$endPoint", queryString);

    if (kDebugMode) {
      print("AccessToken: Bearer ${token?.accessToken}");
      print("URL: $token");
      print("Query: $queryString");
    }
    try {
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${token?.accessToken}" ?? ""
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on UnauthorisedException {
      rethrow;
    } on ApiException {
      rethrow;
    }
    return responseJson;
  }

  @override
  Future sendRequest<T>(String endPoint, T? params) async {
    var token = await getAuthToken();

    ApiResponse responseJson;
    var url = Uri.https(baseUrl, "/api/$endPoint");

    if (kDebugMode) {
      print("AccessToken: Bearer ${token?.accessToken}");
      print("URL: $url");
      print("Params: ${jsonEncode(params)}");
    }
    try {
      final response = await http.post(url, body: jsonEncode(params), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${token?.accessToken}" ?? ""
      });

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on UnauthorisedException {
      rethrow;
    } on ApiException {
      rethrow;
    }
    return responseJson;
  }

  @override
  Future updateRequest<T>(String endPoint, T? params) async {
    var token = await getAuthToken();

    ApiResponse responseJson;
    var url = Uri.https(baseUrl, "/api/$endPoint");

    if (kDebugMode) {
      print("AccessToken: Bearer ${token?.accessToken}");
      print("URL: $url");
      print("Params: ${jsonEncode(params)}");
    }

    try {
      final response = await http.put(url, body: jsonEncode(params), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${token?.accessToken}" ?? ""
      });

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on UnauthorisedException {
      rethrow;
    } on ApiException {
      rethrow;
    }
    return responseJson;
  }

  @override
  Future deleteRequest<T>(String endPoint, T? params) async {
    var token = await getAuthToken();

    ApiResponse responseJson;
    var url = Uri.https(baseUrl, "/api/$endPoint");

    if (kDebugMode) {
      print("AccessToken: Bearer ${token?.accessToken}");
      print("URL: $url");
      print("Params: ${jsonEncode(params)}");
    }
    try {
      final response =
          await http.delete(url, body: jsonEncode(params), headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${token?.accessToken}" ?? ""
      });

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on UnauthorisedException {
      rethrow;
    } on ApiException {
      rethrow;
    }
    return responseJson;
  }

  ApiResponse returnResponse(http.Response httpResponse) {
    if (kDebugMode) {
      print("Http Code: ${httpResponse.statusCode}");
    }
    switch (httpResponse.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(httpResponse.body);
        if (kDebugMode) {
          print("Response: $responseJson");
        }

        var response = ApiResponse.fromJson(responseJson);

        if (response.code != 200) {
          throw ApiException(response.message);
        }
        return ApiResponse.fromJson(responseJson);
      case 400:
        throw BadRequestException(httpResponse.body.toString());
      case 401:
        throw UnauthorisedException(httpResponse.statusCode.toString());
      case 403:
        throw UnauthorisedException(httpResponse.body.toString());
      case 404:
        throw UnauthorisedException(httpResponse.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${httpResponse.statusCode}');
    }
  }
}
