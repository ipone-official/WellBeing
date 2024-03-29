import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'src/app.dart';



Future<void> main() async {
   HttpOverrides.global = MyHttpOverrides();
  //  SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown
  //   ]).then((_){
  //     runApp(const App());
  // });
  runApp(const App());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}