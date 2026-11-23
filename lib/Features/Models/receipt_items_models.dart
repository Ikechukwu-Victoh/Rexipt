class ReceiptItemModel {
  final String itemName;
  final int quantity;
  final double unitPrice;
  final String description;

  const ReceiptItemModel({
    required this.itemName,
    required this.quantity,
    required this.unitPrice,
    required this.description,
  });

  double get subtotal => quantity * unitPrice;
}
