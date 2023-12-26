import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/helper/resources.dart';
import 'package:instagram_clone/pages/home_page.dart';
import 'package:instagram_clone/pages/upload_image.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {

String userName="user";
String? userImage="https://www.moroccoupclose.com/uwagreec/2018/12/default_avatar-2048x2048.png";
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }



  void savePost() async {
    print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq");
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: AlertDialog(actions: [
            Center(child: CircularProgressIndicator()),
          ], title: Center(child: Text("Saving.."))),
        );
      },
    );
    String resp = await storeData().savePostData(
        name: userName,
        userImage: userImage!,
        caption: captionController.text, file: _image!
        );
     
        print(captionController.text);

     Navigator.pop(context);
     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),));
  }

  Uint8List? _image;
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  TextEditingController captionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Upload image"),actions: [IconButton(onPressed: (){
        FirebaseAuth.instance.signOut();
      }, icon: Icon(Icons.logout)),],),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
               future: getUserDetails(),
        builder: (context, snapshot) {
          //during loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error :${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data!.data();
            userName=user!['username'];
            userImage=user['imageLink'];
            return  Container(
          margin: EdgeInsets.all(20),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  child: TextField(
                    controller: captionController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.edit),
                      border: OutlineInputBorder(),
                      labelText: "Write a caption...",
                    ),
                  ),
                  
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: selectImage,
                  child: _image != null
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            height: 400,
                            color: Colors.grey[400],
                            child: Image.memory((_image!)),
                          ))
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: double.infinity,
                            height: 400,
                            color: Colors.grey[400],
                            child: Icon(Icons.file_upload_outlined),
                          ),
                        ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    child: ElevatedButton(
                  onPressed: savePost,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: const Text("Post"),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                ))
              ],
            ),
          ),
        );
        
          }
           else {
            return Center(
              child: Text("No Data Found"),
            );
          }
        }


        // child: Container(
        //   margin: EdgeInsets.all(20),
        //   child: Center(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.end,
        //       children: [
        //         Container(
        //           child: TextField(
        //             controller: captionController,
        //             decoration: InputDecoration(
        //               prefixIcon: Icon(Icons.edit),
        //               border: OutlineInputBorder(),
        //               labelText: "Write a caption...",
        //             ),
        //           ),
                  
        //         ),
        //         SizedBox(
        //           height: 30,
        //         ),
        //         InkWell(
        //           onTap: selectImage,
        //           child: _image != null
        //               ? Padding(
        //                   padding: const EdgeInsets.all(10.0),
        //                   child: Container(
        //                     width: double.infinity,
        //                     height: 400,
        //                     color: Colors.grey[400],
        //                     child: Image.memory((_image!)),
        //                   ))
        //               : Padding(
        //                   padding: const EdgeInsets.all(10.0),
        //                   child: Container(
        //                     width: double.infinity,
        //                     height: 400,
        //                     color: Colors.grey[400],
        //                     child: Icon(Icons.file_upload_outlined),
        //                   ),
        //                 ),
        //         ),
        //         SizedBox(
        //           height: 15,
        //         ),
        //         Container(
        //             child: ElevatedButton(
        //           onPressed: savePost,
        //           child: Padding(
        //             padding: const EdgeInsets.all(15.0),
        //             child: const Text("Post"),
        //           ),
        //           style: ElevatedButton.styleFrom(
        //               backgroundColor: Colors.blue,
        //               foregroundColor: Colors.white),
        //         ))
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
