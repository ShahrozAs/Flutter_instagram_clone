import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/profile_page.dart';

class ImageClick extends StatelessWidget {
  const ImageClick({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameEditController=TextEditingController();
    return Scaffold(
      body: Center(
        child: TextField(
          controller: nameEditController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Enter your Name",
            hintText: "John doe"
          ),
        )
      ),
    );
  }
}