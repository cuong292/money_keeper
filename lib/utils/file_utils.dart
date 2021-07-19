import 'dart:io';

import 'package:base_flutter/constant/constant_color.dart';
import 'package:base_flutter/screen/pdf_view_widget.dart';
import 'package:base_flutter/screen/video_player_widget.dart';
import 'package:base_flutter/screen/webview_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';

class FileUtils {
  static bool isPDF(String path) {
    return lookupMimeType(path)!.contains('pdf');
  }

  static bool isImage(String path) {
    return lookupMimeType(path)!.contains('image');
  }

  static bool isVideo(String path) {
    return lookupMimeType(path)!.contains('video');
  }

  static bool isAudio(String path) {
    return lookupMimeType(path)!.contains('video');
  }

  static openFile(String path, BuildContext context) async {
    // path =
    //     'https://file-examples-com.github.io/uploads/2017/02/file-sample_100kB.doc';
    if (isPDF(path)) {
      File file = await openFileCacheOrOnline(path);
      openPDF(file, context);
    } else if (isVideo(path)) {
      openVideo(path, context);
    } else {
      if (await isFileOnline(path)) {
        openInWebView(path, context);
      } else {
        OpenFile.open(
          path,
          type: lookupMimeType(path),
        ).catchError((onError) {
          print(onError.toString());
        });
      }
    }
  }

  static Future<bool> isFileLocal(String path) async {
    return await File(path).exists();
  }

  static Future<bool> isFileOnline(String path) async {
    var rs = await isFileLocal(path);
    return !rs;
  }

  static Future<File> openFileCacheOrOnline(String path) async {
    var fileCache = await DefaultCacheManager().getFileFromMemory(path);
    File? file;
    if (fileCache != null) {
      file = fileCache.file;
    } else {
      file = await DefaultCacheManager().getSingleFile(path, key: path);
    }
    return file;
  }

  static openPDF(File file, BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewWidget(file),
      ),
    );
  }

  static openInWebView(String path, BuildContext context) async {
    path = 'https://drive.google.com/gview?url=$path';
    print(path);
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => WebViewWidget(path),
      ),
    );
  }

  static void openVideo(String path, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerWidget(path),
      ),
    ).then((value) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: ConstColor.colorPrimary,
        statusBarColor: ConstColor.colorPrimary,
      ));
    });
  }

  static String getFileName(String path) {
    return basename(path);
  }
}
