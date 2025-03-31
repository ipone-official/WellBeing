import 'dart:convert';
import 'dart:io' show HttpClient, HttpHeaders, X509Certificate; // เฉพาะ platform non-web เท่านั้น
import 'package:flutter/foundation.dart'; // สำหรับ kIsWeb
import 'package:dio/dio.dart';
import 'package:dio/io.dart'; // สำหรับ DefaultHttpClientAdapter
import 'package:wellbeing/src/Pages/models/UserAd.dart';
import 'package:wellbeing/src/constants/network_api.dart';

class LoginAdApi {
  final Dio _dio = Dio();

  LoginAdApi() {
    // ✅ ป้องกัน error บน Web
    if (!kIsWeb) {
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
  }

  Future<UserAd> fUserAd(userId, password) async {
    var params = {"username": userId, "password": password};
    String url = NetworkAPI.loginAd;

    final response = await _dio.post(
      url,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
      data: jsonEncode(params),
    );

    return userAdFromJson(jsonEncode(response.data));
  }
}
