import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/CustomBottomNavigationBar.dart';
import 'package:instagram_clone/components/full_image.dart';
import 'package:instagram_clone/helper/helper_functions.dart';
import 'package:instagram_clone/pages/home_page.dart';
import 'package:instagram_clone/pages/profile_page.dart';
import 'package:instagram_clone/pages/uploadPost_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // String imageUrl="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded,color: Color(0xffFD1D59),)),
        title: Text('Search'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('UsersPost').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            displayMessageToUser("Something went wrong", context);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return Center(
              child: Text("No data found"),
            );
          }

          // if (!snapshot.hasData) {
          //   return Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot post = snapshot.data!.docs[index];
              Map<String, dynamic> postData =
                  post.data() as Map<String, dynamic>;
              String imageUrl = postData['imageLink'] ?? '';

              return GestureDetector(
                onTap: () {
                  // Handle post click
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FullImagePreview(imageUrl: imageUrl),
                      ));
                },
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: 200.0,
                ),
              );
            },
          );
        },
      ),
      
       bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   selectedItemColor: Color(0xffFD1D59),
      //   unselectedItemColor: Colors.grey,
      //   showSelectedLabels: true,
      //   showUnselectedLabels: true,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add_circle),
      //       label: 'Upload',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.video_collection),
      //       label: 'Videos',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],

      //   currentIndex: 1, // Set the initial index to Home
      //   onTap: (index) {
      //     // Handle navigation on item tap
      //     switch (index) {
      //       case 0:
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => HomePage(),
      //             ));
      //         break;
      //       case 1:
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => SearchPage(),
      //             ));
      //         // Navigator.pushNamed(context, searchScreenRoute);
      //         break;
      //       case 2:
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => UploadPostPage(),
      //             ));
      //         // Navigator.pushNamed(context, uploadScreenRoute);
      //         break;
      //       case 3:
      //         //Navigator.pushNamed(context, videosScreenRoute);
      //         break;
      //       case 4:
      //         // Navigator.pushNamed(context, profileScreenRoute);
      //         Navigator.push(
      //             context,
      //             MaterialPageRoute(
      //               builder: (context) => ProfilePage(),
      //             ));
      //         break;
      //     }
      //   },
      // ),

    );
  }
}
