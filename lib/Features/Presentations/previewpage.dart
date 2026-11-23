import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:lucide_icons_flutter/test_icons.dart';
import 'package:rexipt/auth/bloc/auth_cubit.dart';
import 'package:rexipt/auth/bloc/auth_state.dart';

class Previewpage extends StatelessWidget {
  Previewpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 60),
            child: Text(
              'Rexipt',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,

      body: BlocBuilder<ReceiptCubit, ReceiptState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Receipt Review',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text('Review your receipt before sharing'),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(221, 120, 120, 120),
                        blurRadius: 3,
                        spreadRadius: 1,
                        offset: Offset(0, 0),
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset(
                          'assets/images/shop logo.jpg',
                          width: 80,
                        ),
                      ),
                      Text(
                        'Omega Phones and Gadjets',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('IT services and gadjets'),
                      Text('12 Adeola Ibeku St. victoria island lagos'),
                      Text('+23490453212'),
                      Text('info@gmail.com'),
                      Divider(color: Colors.orange),
                      Row(
                        children: [Text('Receipt Number :'), Text('TNX323134')],
                      ),

                      Row(children: [Text('Date: '), Text('27 Dec 2027')]),
                      Row(
                        children: [
                          Text('Customer: '),
                          Text('Victoria Adebayo'),
                        ],
                      ),

                      Row(children: [Text('Payment Method: '), Text('Cash')]),

                      Row(
                        children: [
                          Text('Status: '),
                          Text(
                            'Paid',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final item = state.items[index];

                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Phone Name: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          item.itemName,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Text(
                                          " QTY: ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),

                                        Text(
                                          '${item.quantity}',
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(width: 25),
                                Text(
                                  '${item.subtotal}',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      Text('Total Price :'),
                      Text('${state.GrandTotal.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget ItemsDescription() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),

      Text(" QTY", style: TextStyle(fontWeight: FontWeight.bold)),

      Text("SubTotal", style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  );
}
