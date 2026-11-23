import 'package:rexipt/Features/Models/receipt_items_models.dart';

class ReceiptState {
  final List<ReceiptItemModel> items;
  ReceiptState({this.items = const []});

  double get totalAmount {
    return items.fold<double>(0, (sum, item) => sum + item.subtotal);
  }

  ReceiptState copyWith({List<ReceiptItemModel>? items}) {
    return ReceiptState(items: items ?? this.items);
  }

  double get GrandTotal {
    return items.fold(0.0, (sum, item) => sum + item.subtotal);
  }
}
