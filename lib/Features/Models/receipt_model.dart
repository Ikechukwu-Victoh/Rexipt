import 'package:rexipt/Features/Models/receipt_items_models.dart';

class ReceiptModel {
  final String customerName;
  final String customerAddress;
  final String? customerPhone;
  final DateTime date;
  final String paymentMethod;
  final List<ReceiptItemModel> items;
  final double amountPaid;

  const ReceiptModel({
    required this.customerName,
    required this.customerAddress,
    this.customerPhone,
    required this.date,
    required this.paymentMethod,
    required this.items,
    required this.amountPaid,
  });

  double get totalAmount =>
      items.fold<double>(0, (sum, item) => sum + item.subtotal);

  double get balanceDue => totalAmount - amountPaid;

  String get paymentStatus {
    if (amountPaid <= 0) return 'Pending';
    if (amountPaid >= totalAmount) return 'Paid';
    return 'Part Payment';
  }
}
