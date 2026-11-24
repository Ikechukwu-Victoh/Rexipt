import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:rexipt/Features/Presentations/additemsforms.dart';
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

  // Save customer details and continue
  void _addCustomerDetails() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Save customer details to ReceiptCubit
    context.read<ReceiptCubit>().updateCustomerDetails(
      name: _customerName.text.trim(),
      phone: _PhoneNumberController.text.trim(),
      email: _CustomerEmailController.text.trim(),
      address: _cutomeraddress.text.trim(),
    );

    // Navigate only after successful validation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Additemsforms()),
    );
  }

  @override
  void dispose() {
    _PhoneNumberController.dispose();
    _customerName.dispose();
    _cutomeraddress.dispose();
    _CustomerEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
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

                  // Customer Name
                  RecieptFormTextfield(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Customer's Name is required";
                      }
                      return null;
                    },
                    Title: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.grey),
                        text: "Name",
                        children: [
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    keyboardtype: TextInputType.name,
                    controller: _customerName,
                    icon: LucideIcons.user,
                  ),

                  // Customer Phone
                  RecieptFormTextfield(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Phone Number is required';
                      }

                      final phone = value.trim();

                      if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(phone)) {
                        return 'Enter a valid phone number';
                      }

                      return null;
                    },
                    Title: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.grey),
                        text: "Phone Number ",
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    keyboardtype: TextInputType.phone,
                    controller: _PhoneNumberController,
                    icon: LucideIcons.phone,
                  ),

                  // Customer Email (Optional)
                  RecieptFormTextfield(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return null;
                      }

                      final email = value.trim();

                      if (!RegExp(
                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                      ).hasMatch(email)) {
                        return 'Enter a valid email address';
                      }

                      return null;
                    },
                    Title: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.grey),
                        text: "Email ",
                        children: [
                          TextSpan(
                            text: '(Optional)',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    keyboardtype: TextInputType.emailAddress,
                    controller: _CustomerEmailController,
                    icon: LucideIcons.mail,
                  ),

                  // Customer Address
                  RecieptFormTextfield(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Address is required';
                      }
                      return null;
                    },
                    Title: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.grey),
                        text: "Address",
                        children: [
                          TextSpan(
                            text: '*',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    keyboardtype: TextInputType.streetAddress,
                    controller: _cutomeraddress,
                    icon: LucideIcons.mapPin,
                  ),

                  // Payment Method
                  Row(
                    children: [
                      Flexible(
                        child: AppDropdown(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select a payment method";
                            }
                            return null;
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
                    ],
                  ),

                  const SizedBox(height: 30),

                  MyContainerButtons(
                    ontap: _addCustomerDetails,
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
