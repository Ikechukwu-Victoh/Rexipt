import 'package:flutter/material.dart';

class MyContainerButtons extends StatelessWidget {
  final VoidCallback ontap;
  final String label;
  final IconData icon;
  MyContainerButtons({
    super.key,
    required this.ontap,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,

      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Text(label, style: TextStyle(color: Colors.white)),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
