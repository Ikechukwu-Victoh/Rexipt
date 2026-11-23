import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:rexipt/Features/Presentations/receipt_form.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReceiptForm()),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(100),
        ),
        backgroundColor: const Color.fromARGB(255, 108, 1, 1),
        child: FaIcon(FontAwesomeIcons.plus, color: Colors.white),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              color: const Color.fromARGB(255, 5, 1, 74),
              child: Container(child: _UserDetails()),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 600,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 237, 236, 236),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 80,
              left: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/shop logo.jpg',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _UserDetails() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Shopmore Gadjets',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      SizedBox(height: 15),

      Text(
        'Home \n for quality phones and gadjets',
        style: TextStyle(fontSize: 12, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 15),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(
                FontAwesomeIcons.locationPin,
                size: 20,
                color: Colors.white,
              ),
              SizedBox(width: 4),
              Text(
                '16 Commercial Street Lagos ',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.phone, size: 20, color: Colors.white),
              SizedBox(width: 4),
              Text(
                '09054783728 ',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              FaIcon(FontAwesomeIcons.envelope, size: 20, color: Colors.white),
              SizedBox(width: 5),
              Text(
                'megaphone123@gmail.com',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
