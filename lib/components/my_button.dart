import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top:5.0),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue[600],
              borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
              child: Text(text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white))),
        ),
      ),
    );
  }
}
