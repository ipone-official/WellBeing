import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:http_parser/http_parser.dart';
import 'package:universal_io/io.dart';
import 'package:wellbeing/src/Pages/models/contact.dart';
import 'package:wellbeing/src/Pages/models/history_runner.dart';
import 'package:wellbeing/src/Pages/models/rank_runner.dart';
import 'package:wellbeing/src/Pages/models/users.dart';
import 'package:wellbeing/src/constants/network_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/rank_me_runner .dart';

// Singleton or Factory Design Pattern
class NetworkService {
  // NetworkService._internal();
  // static final NetworkService _instance = NetworkService._internal();

  // factory NetworkService() => _instance;

  // static final Dio _dio = Dio()
  //   ..interceptors.add(
  //     InterceptorsWrapper(
  //       onRequest: (options, handler) {
  //         options.baseUrl = NetworkAPI.baseURL;
  //         return handler.next(options);
  //       },
  //       onResponse: (response, handler) async {
  //         // await Future.delayed(Duration(seconds: 10));
  //         return handler.next(response);
  //       },
  //       onError: (DioError e, handler) {
  //         switch (e.response?.statusCode) {
  //           case 301:
  //             break;
  //           case 401:
  //             break;
  //           case 404:
  //             break;
  //           default:
  //         }
  //         return handler.next(e);
  //       },
  //     ),
  //   );
  final Dio _dio = Dio();
  // NetworkService() {
  //   (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
  //       (HttpClient client) {
  //     client.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;
  //     return client;
  //   };
  // }

  Future<String> Login(String userId, String password) async {
    try {
      var params = {"userId": userId, "password": password};
      String url = '${NetworkAPI.baseURL}${NetworkAPI.login}';

      Response response = await _dio.post(
        url,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        print("Sucess");
        return '200';
      }
      return '200';
    } catch (e) {
      print('catch: $e');
      return '500';
    }
  }

  Future<List<Users>> getUser(String employeeId) async {
    String url =
        '${NetworkAPI.baseURL}${NetworkAPI.getUser}?employeeId=${employeeId}';
    final response = await _dio.get(url);
    return usersFromJson(jsonEncode(response.data));
  }

  Future<List<RankRunner>> getRankRunner() async {
    String url = '${NetworkAPI.baseURL}${NetworkAPI.rankRunner}';
    final response = await _dio.get(url);
    return rankRunnerFromJson(jsonEncode(response.data));
  }

  Future<List<RankMeRunner>> getMeRunner(String employeeId) async {
    String url =
        '${NetworkAPI.baseURL}${NetworkAPI.meRunner}?employeeId=${employeeId}';
    final response = await _dio.get(url);
    return rankMeRunnerFromJson(jsonEncode(response.data));
  }

  Future<List<HistoryRunner>> getHistory(String employeeId) async {
    String url =
        '${NetworkAPI.baseURL}${NetworkAPI.history}?employeeId=${employeeId}';
    final response = await _dio.get(url);
    return historyRunnerFromJson(jsonEncode(response.data));
  }

  Future<List<Contact>> getContact(String Activity) async {
    String url =
        '${NetworkAPI.baseURL}${NetworkAPI.contact}?Activity=${Activity}';
    final response = await _dio.get(url);
    return contactFromJson(jsonEncode(response.data));
  }

  Future<String> postRecordRunner(
      String employeeId, String record, File imageFile) async {
    try {
          String fileName = '${employeeId}_${imageFile.path.split('/').last}';
      var params = {
        "employeeId": employeeId,
        "record": record.toString(),
        "image":
            'https://webapps.ip-one.com/NodeApiSurveyCambodia/imageRunner/${fileName}'
      };
      String urlRecord = '${NetworkAPI.baseURL}${NetworkAPI.InsertRunner}';
      await Dio().post(
        urlRecord,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: "application/json"}),
        data: jsonEncode(params),
      );

      print("imageFile");
      print(imageFile);
      FormData formData = FormData.fromMap({
        if (imageFile != null)
          'file': await MultipartFile.fromFile(
                      imageFile.path,
            filename: fileName,
            contentType: new MediaType("image", "jpg"),
          ),
      });

      String urlInsertImage = NetworkAPI.uploadImageRunner;
      Response response = await Dio().post(
        urlInsertImage,
        data: formData,
      );
      if (response.statusCode == 200) {
        return '200';
      }
      return '400';
    } catch (e) {
      print('catch: $e');
      return '500';
    }
  }
}
