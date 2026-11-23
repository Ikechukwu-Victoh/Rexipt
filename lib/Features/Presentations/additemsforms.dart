import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:lucide_icons_flutter/lucide_icons_weights.dart';
import 'package:rexipt/Features/Models/receipt_items_models.dart';
import 'package:rexipt/Widgets/Dropdown.dart';
import 'package:rexipt/Widgets/Elevatedbuttons.dart';
import 'package:rexipt/Widgets/reciept_form_textfield.dart';
import 'package:rexipt/auth/bloc/auth_cubit.dart';

class Additemsforms extends StatefulWidget {
  const Additemsforms({super.key});

  @override
  State<Additemsforms> createState() => _AdditemsformsState();
}

class _AdditemsformsState extends State<Additemsforms> {
  String? selectedPaymentMethod;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemQuantityController = TextEditingController();
  final TextEditingController _itemUnitpriceController =
      TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();

  void _addItem() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final item = ReceiptItemModel(
      itemName: _itemNameController.text.trim(),
      quantity: int.parse(_itemQuantityController.text),
      unitPrice: double.parse(_itemUnitpriceController.text),
      description: _itemDescriptionController.text.trim(),
    );

    context.read<ReceiptCubit>().addItem(item);

    _itemNameController.clear();
    _itemQuantityController.clear();
    _itemDescriptionController.clear();
    _itemUnitpriceController.clear();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemQuantityController.dispose();
    _itemDescriptionController.dispose();
    _itemUnitpriceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 30,

        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Back',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: 20,
          horizontal: 10,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                RichText(
                  text: TextSpan(
                    text: 'Customer Details \n',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: 'Who are we generating this receipt for ?',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                RecieptFormTextfield(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter item name';
                    }
                    return null;
                  },
                  Title: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      text: "Item Name ",
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  keyboardtype: TextInputType.text,
                  controller: _itemNameController,

                  icon: LucideIcons.package,
                ),

                RecieptFormTextfield(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter Description';
                    }
                    return null;
                  },
                  Title: RichText(
                    text: TextSpan(
                      text: 'Add Dsecription',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  icon: LucideIcons.fileText,
                  controller: _itemDescriptionController,
                ),

                RecieptFormTextfield(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter Description ';
                    }
                    return null;
                  },
                  Title: RichText(
                    text: TextSpan(
                      text: 'Quantity',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  icon: LucideIcons.hash,
                  controller: _itemQuantityController,
                ),

                RecieptFormTextfield(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the item unit price';
                    }
                    final quantity = int.tryParse(value);
                    if (quantity == null) {
                      return 'Enter whole number';
                    }
                    if (quantity <= 0) {
                      return 'Price must be higher than 0';
                    }
                  },
                  Title: RichText(
                    text: TextSpan(
                      text: 'Unit Price ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  icon: LucideIcons.wallet,
                  controller: _itemUnitpriceController,
                ),

                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.plus, color: Colors.blueAccent),
                      Text(
                        'Add Item',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                MyContainerButtons(
                  ontap: _addItem,
                  label: 'Generate Receipt',
                  icon: LucideIcons100.fileCheck,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
