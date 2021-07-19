import 'dart:io';

import 'package:base_flutter/constant/constant_color.dart';
import 'package:base_flutter/utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String path;
  String? title;

  WebViewWidget(this.path, {this.title});

  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? FileUtils.getFileName(widget.path).trim()),
        backgroundColor: ConstColor.colorPrimary,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: widget.path,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                print(controller);
              },
            ),
          ],
        ),
      ),
    );
  }
}
