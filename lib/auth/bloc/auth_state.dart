import 'package:rexipt/Features/Models/receipt_items_models.dart';

class ReceiptState {
  // Receipt items
  final List<ReceiptItemModel> items;

  // Customer details
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final String customerAddress;

  ReceiptState({
    this.items = const [],
    this.customerName = '',
    this.customerPhone = '',
    this.customerEmail = '',
    this.customerAddress = '',
  });

  double get totalAmount {
    return items.fold<double>(0, (sum, item) => sum + item.subtotal);
  }

  ReceiptState copyWith({
    List<ReceiptItemModel>? items,
    String? customerName,
    String? customerPhone,
    String? customerEmail,
    String? customerAddress,
  }) {
    return ReceiptState(
      items: items ?? this.items,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerEmail: customerEmail ?? this.customerEmail,
      customerAddress: customerAddress ?? this.customerAddress,
    );
  }
}
