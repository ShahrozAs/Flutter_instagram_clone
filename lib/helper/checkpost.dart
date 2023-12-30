import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/full_image.dart';
import 'package:instagram_clone/helper/helper_functions.dart';
class ShowPost extends StatelessWidget {
  final String userName;
  ShowPost({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
       Container(
        height: 400,
         child: Padding(
          padding: EdgeInsets.all(0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('UsersPost')
                .where('name', isEqualTo: userName)
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
              // List<Widget> postWidgets = snapshot.data!.docs.map((post) {
              //   Map<String, dynamic> postData =
              //       post.data() as Map<String, dynamic>;
              //   String imageUrl = postData['imageLink'] ?? '';
         
              //   return GestureDetector(
              //     onTap: () {
              //       // Handle post click
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => FullImagePreview(
              //             imageUrl: imageUrl,
              //           ),
              //         ),
              //       );
              //     },
              //     child: Image.network(
              //       imageUrl,
              //       fit: BoxFit.cover,
              //       height: 200.0,
              //     ),
              //   );
              // }).toList();
         
              // return Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     // Other widgets can be added before the post widgets
              //     // SizedBox(height: 20),
              //     // Text('Your other widgets here'),
              //     // SizedBox(height: 20),
              //     Wrap(
              //       spacing: 2.0,
              //       runSpacing: 2.0,
              //       children: postWidgets,
              //     ),
              //   ],
              // );
            },
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
