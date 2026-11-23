import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rexipt/Features/Models/receipt_items_models.dart';
import 'package:rexipt/Features/Models/receipt_model.dart';
import 'package:rexipt/auth/bloc/auth_state.dart';

class ReceiptCubit extends Cubit<ReceiptState> {
  ReceiptCubit() : super(ReceiptState());

  // add multiple items
  void addItem(ReceiptItemModel item) {
    final updatedItems = [...state.items, item];

    emit(state.copyWith(items: updatedItems));
  }

  // remove items
  void removeItem(int index) {
    final updatedItems = [...state.items];

    updatedItems.removeAt(index);

    emit(ReceiptState(items: updatedItems));
  }
}
