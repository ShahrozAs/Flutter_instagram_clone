import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/full_image.dart';
import 'package:instagram_clone/helper/helper_functions.dart';
class SavedPostPage extends StatelessWidget {
  // final String userName;
  SavedPostPage({Key? key}) : super(key: key);
final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
       appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffFBA943),
                Color(0xffE33A61),
                Color(0xffA134B4),
              ],
              // begin: Alignment.topCenter,
              // end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "Favorites",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
             color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
         body: Padding(
           padding: const EdgeInsets.all(5.0),
           child: Container(
            color: Colors.white,
             child: Padding(
              padding: EdgeInsets.all(0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('UsersSavedPost')
                    .where('email', isEqualTo: user.email!)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return _buildErrorMessage("Something went wrong");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return _buildErrorMessage("No data found");
                  }
                    return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5.0,
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
                   ),
           ),
         ),
       );
   
  }

  Widget _buildErrorMessage(String message) {
    return Center(
      child: Text(
        message,
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
