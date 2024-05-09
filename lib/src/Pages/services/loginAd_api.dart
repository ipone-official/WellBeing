import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:wellbeing/src/Pages/models/UserAd.dart';
import 'package:wellbeing/src/constants/network_api.dart';

class LoginAdApi {
    final Dio _dio = Dio();

  LoginAdApi() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<UserAd> fUserAd(userId, password) async {
    print('fUserAd');
    var params = {"username": userId, "password": password};
      String url = '${NetworkAPI.loginAd}';
      Response response = await _dio.post(
        url,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: jsonEncode(params),
      );
      return userAdFromJson(jsonEncode(response.data));
  }
}