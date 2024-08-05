import 'package:flutter/material.dart';
import '../view_models/pdf_view_model.dart';
import 'pdf_preview_screen.dart';

class SaveScreen extends StatelessWidget {
  final PdfViewModel viewModel = PdfViewModel();

  SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            _showLoadingDialog(context);
            final pdfFile = await viewModel.generatePdf();
            if (!context.mounted) {
              return;
            }

            Navigator.pop(context);
            _previewPdf(context, pdfFile);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.all(16),
          ),
          child: const Text(
            'Save PDF',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 16),
                Text("Generating PDF..."),
              ],
            ),
          ),
        );
      },
    );
  }

  void _previewPdf(BuildContext context, String pdfPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfPreviewScreen(path: pdfPath),
      ),
    );
  }
}
