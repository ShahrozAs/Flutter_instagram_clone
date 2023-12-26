import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
 final void Function()? onTap;
  const MyButton({super.key,required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child:  Container(
                    
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: Text(
                              text,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                     
                      ),

    );
  }
}