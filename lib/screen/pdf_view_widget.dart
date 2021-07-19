import 'dart:io';

import 'package:base_flutter/utils/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PdfViewWidget extends StatefulWidget {
  final String? title;
  final File file;

  PdfViewWidget(this.file, {this.title});

  @override
  _PdfViewWidgetState createState() => _PdfViewWidgetState();
}

class _PdfViewWidgetState extends State<PdfViewWidget> {
  late PdfController pdfController;

  @override
  void initState() {
    super.initState();
    pdfController = PdfController(
      document: PdfDocument.openFile(widget.file.path),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? FileUtils.getFileName(widget.file.path)),
      ),
      body: ColoredBox(
        color: Colors.white,
        child: PdfView(
          controller: pdfController,
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}
