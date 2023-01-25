import 'package:base_flutter/data/models/profile/update_profile_request.dart';

abstract class BaseApiService {

    // final String baseUrl = "south-county-health-dev.newmediaguru.co";
    final String baseUrl = "";


  Future<dynamic> getResponse(String url, {Map<String, String>? queryString});

  Future<dynamic> sendRequest<T>(String url, T? params);
  Future<dynamic> updateRequest<T>(String url, T? params);
  Future<dynamic> deleteRequest<T>(String url, T? params);

}