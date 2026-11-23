import 'package:flutter/material.dart';
import 'package:rexipt/Widgets/Textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                _LoginHeader(),
                SizedBox(height: 30),

                MyTextField(hintText: 'company LTD'),
                MyTextField(hintText: 'johndoe@example.com'),
                MyTextField(hintText: 'Victoria Island Lagos'),

                MyTextField(hintText: 'Password'),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 70, height: 1, color: Colors.grey),
                    SizedBox(width: 10),
                    Text('Or '),
                    SizedBox(width: 10),
                    Container(width: 70, height: 1, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _LoginHeader() {
  return Column(
    children: [
      Text(
        'Create a new account',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      SizedBox(height: 02),
      Text(
        'Create your Rexiept account \n and enjoy seamless reciept generation ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: const Color.fromARGB(255, 104, 103, 103),
        ),
      ),
    ],
  );
}
