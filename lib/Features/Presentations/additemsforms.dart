import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:lucide_icons_flutter/lucide_icons_weights.dart';
import 'package:rexipt/Features/Models/receipt_items_models.dart';
import 'package:rexipt/Features/Models/receipt_model.dart';
import 'package:rexipt/Features/Presentations/previewpage.dart';
import 'package:rexipt/Widgets/Dropdown.dart';
import 'package:rexipt/Widgets/Elevatedbuttons.dart';
import 'package:rexipt/Widgets/reciept_form_textfield.dart';
import 'package:rexipt/auth/bloc/auth_cubit.dart';
import 'package:rexipt/auth/bloc/auth_state.dart';

class Additemsforms extends StatefulWidget {
  const Additemsforms({super.key});

  @override
  State<Additemsforms> createState() => _AdditemsformsState();
}

class _AdditemsformsState extends State<Additemsforms> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _itemNameController = TextEditingController();

  final TextEditingController _itemQuantityController = TextEditingController();

  final TextEditingController _itemUnitpriceController =
      TextEditingController();

  final TextEditingController _itemDescriptionController =
      TextEditingController();

  // Add item to Cubit
  void _addItem() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final quantity = int.tryParse(_itemQuantityController.text.trim());

    final unitPrice = double.tryParse(_itemUnitpriceController.text.trim());

    if (quantity == null || unitPrice == null) {
      return;
    }

    final item = ReceiptItemModel(
      itemName: _itemNameController.text.trim(),
      quantity: quantity,
      unitPrice: unitPrice,
      description: _itemDescriptionController.text.trim(),
    );

    context.read<ReceiptCubit>().addItem(item);

    // Clear fields after adding item
    _itemNameController.clear();
    _itemQuantityController.clear();
    _itemDescriptionController.clear();
    _itemUnitpriceController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item added successfully'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  // Generate receipt
  void _generateReceipt() {
    final items = context.read<ReceiptCubit>().state.items;

    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one item')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PreviewReceiptScreen()),
    );
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
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Back',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),

        child: SingleChildScrollView(
          child: Form(
            key: _formKey,

            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                RichText(
                  text: const TextSpan(
                    text: 'Add Items \n',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: 'Add products to this receipt',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                // Item Name
                RecieptFormTextfield(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter item name';
                    }
                    return null;
                  },
                  Title: RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.grey),
                      text: 'Item Name ',
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

                // Description
                RecieptFormTextfield(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter description';
                    }
                    return null;
                  },
                  Title: RichText(
                    text: const TextSpan(
                      text: 'Add Description',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  icon: LucideIcons.fileText,
                  controller: _itemDescriptionController,
                ),

                // Quantity
                RecieptFormTextfield(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter quantity';
                    }

                    final quantity = int.tryParse(value.trim());

                    if (quantity == null) {
                      return 'Enter a whole number';
                    }

                    if (quantity <= 0) {
                      return 'Quantity must be greater than 0';
                    }

                    return null;
                  },
                  Title: RichText(
                    text: const TextSpan(
                      text: 'Quantity ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  keyboardtype: TextInputType.number,
                  icon: LucideIcons.hash,
                  controller: _itemQuantityController,
                ),

                // Unit Price
                RecieptFormTextfield(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter unit price';
                    }

                    final price = double.tryParse(value.trim());

                    if (price == null) {
                      return 'Enter a valid price';
                    }

                    if (price <= 0) {
                      return 'Price must be higher than 0';
                    }

                    return null;
                  },
                  Title: RichText(
                    text: const TextSpan(
                      text: 'Unit Price ',
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  keyboardtype: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  icon: LucideIcons.wallet,
                  controller: _itemUnitpriceController,
                ),

                // Add Item Container with Counter
                BlocBuilder<ReceiptCubit, ReceiptState>(
                  builder: (context, state) {
                    final itemCount = state.items.length;

                    return InkWell(
                      onTap: _addItem,
                      borderRadius: BorderRadius.circular(10),

                      child: Container(
                        height: 45,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue),
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              LucideIcons.plus,
                              color: Colors.blueAccent,
                            ),

                            const SizedBox(width: 8),

                            const Text(
                              'Add Item',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(width: 10),

                            // Item counter
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '$itemCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Generate Receipt
                MyContainerButtons(
                  ontap: _generateReceipt,
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
