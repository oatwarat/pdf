import '../services/pdf_service.dart';
import '../models/barcode_item.dart';

class PdfViewModel {
  final PdfService _pdfService = PdfService();

  Future<String> generatePdf() async {
    final items = _getSampleItems();
    return _pdfService.generatePdf(items);
  }

  List<BarcodeItem> _getSampleItems() {
    return List.generate(
      50,
      (index) => BarcodeItem(
        itemBarcode: '31000${3576100 + index * 5000}',
        itemTitle: 'Sample Item ${index + 1}',
        amount: 1,
        price: 10.00 + index,
        itemUnit: 'pc',
      ),
    );
  }
}
