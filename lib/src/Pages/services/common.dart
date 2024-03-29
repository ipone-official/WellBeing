import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wellbeing/src/app.dart';


Future<Uint8List> getBytesFromAsset(
  String path, {
  required int width,
}) async {
  ByteData data = await rootBundle.load(path);
  Codec codec = await instantiateImageCodec(
    data.buffer.asUint8List(),
    targetWidth: width,
  );
  FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List();
}

void hideKeyboard() {
  FocusScope.of(navigatorState.currentContext!).requestFocus(FocusNode());
}
