import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_plus/share_plus.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String path;

  const PdfPreviewScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Preview"),
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _sharePdf(context),
              );
            },
          ),
        ],
      ),
      body: PDFView(filePath: path),
    );
  }

  void _sharePdf(BuildContext context) {
    final RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      final Rect bounds = box.paintBounds;
      if (bounds.size.width > 0 && bounds.size.height > 0) {
        Share.shareXFiles(
          [XFile(path)],
          text: 'Here is the PDF...',
          sharePositionOrigin: bounds,
        );
      } else {
        _sharePdfWithoutOrigin();
      }
    } else {
      _sharePdfWithoutOrigin();
    }
  }

  void _sharePdfWithoutOrigin() {
    Share.shareXFiles([XFile(path)], text: 'Here is the PDF...');
  }
}
