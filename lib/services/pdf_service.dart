import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import '../models/barcode_item.dart';
import '../utils/pdf_utils.dart';
import 'package:flutter/material.dart';

class PdfService {
  Future<String> generatePdf(List<BarcodeItem> items) async {
    final pdf = pw.Document();
    final pageFormat = PdfPageFormat.a4;
    const itemSize = Size(200, 100);
    const padding = EdgeInsets.all(10);

    int itemsPerPage =
        PdfUtils.calculateItemsPerPage(pageFormat, itemSize, padding);
    int pageCount = (items.length / itemsPerPage).ceil();

    for (int i = 0; i < pageCount; i++) {
      final pageItems =
          items.skip(i * itemsPerPage).take(itemsPerPage).toList();

      pdf.addPage(
        pw.Page(
          pageFormat: pageFormat,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Wrap(
                spacing: padding.right,
                runSpacing: padding.bottom,
                children: pageItems
                    .map((item) => PdfUtils.buildItemWidget(item))
                    .toList(),
              ),
            );
          },
        ),
      );
    }

    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/pos.pdf');
    await file.writeAsBytes(await pdf.save());
    return file.path;
  }
}
