import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:rexipt/Features/Models/receipt_items_models.dart';
import 'package:rexipt/Features/Presentations/additemsforms.dart';
import 'package:rexipt/Features/Presentations/previewpage.dart';
import 'package:rexipt/Widgets/Dropdown.dart';
import 'package:rexipt/Widgets/Elevatedbuttons.dart';
import 'package:rexipt/Widgets/reciept_form_textfield.dart';
import 'package:rexipt/auth/bloc/auth_cubit.dart';

class ReceiptForm extends StatefulWidget {
  const ReceiptForm({super.key});

  @override
  State<ReceiptForm> createState() => _ReceiptFormState();
}

class _ReceiptFormState extends State<ReceiptForm> {
  String? selectedPaymentMethod;
  String? selectedPaymentStatus;

  final _formKey = GlobalKey<FormState>();

  final _PhoneNumberController = TextEditingController();
  final _customerName = TextEditingController();
  final _cutomeraddress = TextEditingController();
  final _CustomerEmailController = TextEditingController();

  void _addItem() {
    if (!_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Additemsforms()),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 10),
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
                        return "Cutomer's Name is required";
                      }
                      return null;
                    },
                    Title: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: const Color.fromARGB(255, 138, 137, 137),
                        ),
                        text: "Name",
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    keyboardtype: TextInputType.text,
                    controller: _customerName,

                    icon: LucideIcons.user,
                  ),

                  RecieptFormTextfield(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone Number is required';
                      }
                      return null;
                    },
                    Title: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: const Color.fromARGB(255, 138, 137, 137),
                        ),
                        text: "Phone Number ",
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    keyboardtype: TextInputType.number,
                    controller: _PhoneNumberController,

                    icon: LucideIcons.phone,
                  ),

                  RecieptFormTextfield(
                    Title: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: const Color.fromARGB(255, 138, 137, 137),
                        ),
                        text: " Email ",
                        children: [
                          TextSpan(
                            text: ("(Optional)"),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    controller: _CustomerEmailController,

                    icon: LucideIcons.mail,
                  ),

                  RecieptFormTextfield(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                    Title: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: const Color.fromARGB(255, 138, 137, 137),
                        ),
                        text: "Address",
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    keyboardtype: TextInputType.number,
                    controller: _cutomeraddress,

                    icon: LucideIcons.mapPin,
                  ),

                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          width: 400,
                          child: AppDropdown(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please select a payment method";
                              }
                            },
                            label: 'Payment Method',
                            hint: 'Select Payment Method',
                            items: ['Transfer', 'Cash', 'POS', 'Card'],
                            onChanged: (value) {
                              setState(() {
                                selectedPaymentMethod = value;
                              });
                            },
                            itemLabel: (item) => item,
                            value: selectedPaymentMethod,
                            prefixIcon: const Icon(
                              Icons.account_balance_wallet_outlined,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  MyContainerButtons(
                    ontap: _addItem,
                    label: 'Continue',
                    icon: Icons.arrow_forward,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
