import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:rexipt/Features/Models/receipt_items_models.dart';

import 'package:rexipt/auth/bloc/auth_cubit.dart';
import 'package:rexipt/auth/bloc/auth_state.dart';

class ReceiptPreviewScreen extends StatelessWidget {
  const ReceiptPreviewScreen({super.key});

  static const Color primaryColor = Color(0xFF05037C);

  String formatAmount(double amount) {
    return '₦${amount.toStringAsFixed(2)}';
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String formattedAmount(double amount) {
    return NumberFormat.currency(
      locale: 'en_NG',
      symbol: '₦',
      decimalDigits: 2,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F6),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Receipt Preview',
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 19,
          ),
        ),
      ),

      body: BlocBuilder<ReceiptCubit, ReceiptState>(
        builder: (context, state) {
          final receiptDate = DateTime.now();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.receipt_long_rounded,
                              size: 38,
                              color: primaryColor,
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              'REXIPT',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              'OFFICIAL PAYMENT RECEIPT',
                              style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 1,
                                color: const Color.fromARGB(255, 78, 78, 78),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      const Divider(),

                      _infoRow('Receipt Date', formatDate(receiptDate)),

                      const SizedBox(height: 16),

                      const Divider(),

                      // CUSTOMER INFORMATION
                      _sectionTitle('CUSTOMER DETAILS'),

                      const SizedBox(height: 12),

                      Text(
                        state.customerName.isEmpty
                            ? 'Customer name not provided'
                            : state.customerName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      if (state.customerPhone.isNotEmpty)
                        _detailText(state.customerPhone),

                      if (state.customerEmail.isNotEmpty)
                        _detailText(state.customerEmail),

                      if (state.customerAddress.isNotEmpty)
                        _detailText(state.customerAddress),

                      const SizedBox(height: 20),

                      const Divider(),

                      // ITEM DETAILS
                      _sectionTitle('ITEM DETAILS'),

                      const SizedBox(height: 16),

                      // TABLE HEADER
                      Row(
                        children: [
                          const Expanded(
                            flex: 4,
                            child: Text(
                              'Item',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const Expanded(
                            flex: 1,
                            child: Text(
                              'Qty',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          const Expanded(
                            flex: 2,
                            child: Text(
                              'Subtotal',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // DISPLAY ALL ITEMS
                      if (state.items.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(child: Text('No items added yet')),
                        )
                      else
                        ...state.items.map((item) {
                          return _itemRow(item);
                        }),

                      const Divider(),

                      const SizedBox(height: 12),

                      // GRAND TOTAL
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'TOTAL AMOUNT',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            formattedAmount(state.totalAmount),
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      const Divider(),

                      // FOOTER
                      Center(
                        child: Column(
                          children: [
                            const Text(
                              'Thank you for your patronage!',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              'We appreciate your business.',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // DOWNLOAD BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // PDF generation will be implemented here.
                    },
                    icon: const Icon(Icons.download_rounded),
                    label: const Text('Download Receipt'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // SECTION TITLE
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
      ),
    );
  }

  // CUSTOMER DETAILS
  Widget _detailText(String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        value,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),

          Text(
            value,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _itemRow(ReceiptItemModel item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ITEM NAME AND DESCRIPTION
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.itemName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                if (item.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),

                Text(
                  formattedAmount(item.subtotal),
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),

          // QUANTITY
          Expanded(
            flex: 1,
            child: Text(
              item.quantity.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ),

          // SUBTOTAL
          Expanded(
            flex: 2,
            child: Text(
              formattedAmount(item.subtotal),
              textAlign: TextAlign.end,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
