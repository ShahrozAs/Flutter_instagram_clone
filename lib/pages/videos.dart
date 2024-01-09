import 'package:flutter/material.dart';
import 'package:instagram_clone/components/CustomBottomNavigationBar.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Videos"),),

       bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
      ),
    );
  }
}