import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/pages/home_page.dart';
import 'package:instagram_clone/pages/profile_page.dart';
import 'package:instagram_clone/pages/search_page.dart';
import 'package:instagram_clone/pages/uploadPost_page.dart';
import 'package:instagram_clone/pages/videos.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  CustomBottomNavigationBar({required this.currentIndex});

  void navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(),));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPostPage(),));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => VideosPage(),));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(),));
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      // backgroundColor: Color(0xffEC484F),
      height: 60,
      gradient: LinearGradient(colors: [
        Color(0xffFBA943),
        Color(0xffE33A61),
        Color(0xffA134B4),
      ]),
      
      items:const [
        TabItem(icon: Icons.home, title: 'Home'),
        TabItem(icon: Icons.search_rounded, title: 'Search'),
        TabItem(icon: Icons.add_circle_outline_rounded, title: 'Upload'),
        TabItem(icon: Icons.video_collection_outlined, title: 'Videos'),
        TabItem(icon: Icons.person, title: 'Profile'),
      ],
      initialActiveIndex: currentIndex,
      onTap: (int i) {
        navigateToPage(context, i);
      },
    );
  }
}
