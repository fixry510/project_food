import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

String getUrlExtension(String url) {
  return url.split(RegExp(r'[#?]'))[0].split('.').last.trim();
}

String getFileNameWithoutExtension(String url) {
  return url
      .replaceAll(RegExp(r'\?.*$'), '')
      .split('/')
      .last
      .replaceAll(RegExp(r'\.[^.]+$'), '');
}

Future<File> downloadFile(uri) async {
  Directory dir = await getTemporaryDirectory();
  String nameOfFile = getFileNameWithoutExtension(uri);
  String ext = getUrlExtension(uri);
  String fullFileName = "$nameOfFile.$ext";
  if (!(uri.toString().contains("jpg") ||
      uri.toString().contains("jpeg") ||
      uri.toString().contains("png"))) {
      print(uri);
   fullFileName = "${Random().nextInt(99990)}";
  }
  String path = '${dir.path}/$fullFileName';
  File file = File(path);
  if (!file.existsSync()) {
    await Dio().download( 
      uri,
      path,
      onReceiveProgress: (count, total) {
         print((count / total * 100).toStringAsFixed(0) + "% ${fullFileName}");
      },
      // deleteOnError: true,
    );
  } else {
    // print("Not Load ${fullFileName}");
    // print("Exit ${path}");
  }
  return file;
}
