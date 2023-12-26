import 'package:flutter/material.dart';

class FullImagePreview extends StatelessWidget {
  final String imageUrl;
   FullImagePreview({super.key,required this.imageUrl});

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network('${imageUrl}'),
      ),
    );
  }
}