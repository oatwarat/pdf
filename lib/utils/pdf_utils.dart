import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:barcode/barcode.dart';
import '../models/barcode_item.dart';
import 'package:flutter/material.dart';

class PdfUtils {
  static int calculateItemsPerPage(
      PdfPageFormat pageFormat, Size itemSize, EdgeInsets padding) {
    final pageWidth = pageFormat.availableWidth;
    final pageHeight = pageFormat.availableHeight;
    final itemWidth = itemSize.width + padding.left + padding.right;
    final itemHeight = itemSize.height + padding.top + padding.bottom;

    final columnsPerPage = (pageWidth / itemWidth).floor();
    final rowsPerPage = (pageHeight / itemHeight).floor();

    return columnsPerPage * rowsPerPage;
  }

  static pw.Widget buildItemWidget(BarcodeItem item) {
    final barcode = Barcode.itf();
    final svg = barcode.toSvg(
      item.itemBarcode,
      width: 150,
      height: 15,
      drawText: false,
    );

    return pw.Container(
      width: 200,
      height: 100,
      padding: const pw.EdgeInsets.all(4),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.black),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Text(item.itemTitle,
              style: const pw.TextStyle(fontSize: 12),
              textAlign: pw.TextAlign.center),
          pw.SizedBox(height: 4),
          pw.Stack(
            children: [
              pw.Align(
                alignment: pw.Alignment.center,
                child: pw.Text(item.price.toStringAsFixed(2),
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.center),
              ),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('baht', style: const pw.TextStyle(fontSize: 12)),
              ),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text('Unit: ${item.itemUnit}',
                style: const pw.TextStyle(fontSize: 12)),
          ),
          pw.SizedBox(height: 4),
          pw.SvgImage(svg: svg),
          pw.SizedBox(height: 4),
          pw.Text(item.itemBarcode,
              style: const pw.TextStyle(fontSize: 10, letterSpacing: 2.0),
              textAlign: pw.TextAlign.center),
        ],
      ),
    );
  }
}
