class BarcodeItem {
  String itemBarcode; // รหัสบาโค้ด
  String itemTitle; // ชื่อสินค้า
  double amount; // จำนวนชิ้น
  double price; // ราคา
  String itemUnit; // หน่วย

  BarcodeItem({
    required this.itemBarcode,
    required this.itemTitle,
    required this.amount,
    required this.price,
    required this.itemUnit,
  });
}

class Input {
  List<BarcodeItem> barcodeItems;

  Input({
    required this.barcodeItems,
  });
}
