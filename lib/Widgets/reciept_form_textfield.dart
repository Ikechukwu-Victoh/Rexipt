import 'package:flutter/material.dart';

class RecieptFormTextfield extends StatelessWidget {
  final String? Function(String?)? validator;

  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardtype;
  final Widget Title;
  RecieptFormTextfield({
    super.key,
    required this.Title,
    required this.icon,
    required this.controller,
    this.validator,
    this.keyboardtype = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          validator: validator,
          keyboardType: keyboardtype,
          controller: controller,
          decoration: InputDecoration(
            hint: Title,
            focusColor: const Color.fromARGB(255, 210, 209, 209),
            fillColor: const Color.fromARGB(255, 223, 222, 222),
            filled: true,

            prefixIcon: Icon(
              icon,
              color: const Color.fromARGB(255, 34, 34, 34),
              size: 20,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
