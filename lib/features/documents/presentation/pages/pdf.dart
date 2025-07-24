// lib/presentation/pages/pdf_viewer_page.dart

import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerPage extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerPage({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    final controller = PdfController(document: PdfDocument.openFile(pdfUrl));

    return Scaffold(
      appBar: AppBar(title: const Text("Lecture PDF")),
      body: PdfView(controller: controller),
    );
  }
}
