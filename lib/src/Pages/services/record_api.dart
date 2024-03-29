import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';


class RecordApi {
  final Dio _dio = Dio();
  RecordApi() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
}