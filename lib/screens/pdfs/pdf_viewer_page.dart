import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:classroom_toppers/utils/my_application.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerPage extends StatefulWidget {
  // final File file;
  // final String url;

  const PdfViewerPage({
    Key? key,
    // required this.file,
    // required this.url,
  }) : super(key: key);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  void initState() {
    // print("url>>" + Get.arguments);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: FutureBuilder<String>(
        future: app.appController.downloadPDF(Get.arguments),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PDFView(
              filePath: snapshot.data!,
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading PDF'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
