import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/helper/helper_functions.dart';
// import 'package:instagram_mad/Crud_operations/realtime_database.dart';

void createBottomSheetComments(
    BuildContext context, String name, String docId) {
  TextEditingController commentController = TextEditingController();
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  void addComment() {
    print("helloooooooooooooooooooooooooooooooooo$docId");

    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    FirebaseFirestore.instance
        .collection("UsersPost")
        .doc(docId)
        .collection("Comments")
        .add({
      "commentText": commentController.text,
      "commentBy": currentUser!.email,
      "commentTime": Timestamp.now(),
    });
    Navigator.pop(context);
    commentController.clear();
  }

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(
                  child: Container(
                    height: 3.0,
                    width: 35,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    "Comments",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 15,
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("UsersPost")
                      .doc(docId)
                      .collection("Comments")
                      .orderBy("commentTime", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text("No Comments"),
                      );
                    }
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
                        child: Text("No Comments"),
                      );
                    }
                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: snapshot.data!.docs.map((doc) {
                        final commentData = doc.data() as Map<String, dynamic>;
                        return Padding(
                          padding: EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/profile.png'),
                                    ),
                                    title: Text(commentData['commentBy']),
                                    subtitle: Text(commentData['commentText']),
                                    trailing: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon:
                                                Icon(Icons.favorite_border_rounded)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 75,
                                      ),
                                      Text("Reply"),
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text("See translation"),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
            
                
        
              ],
            ),
        
        
                    TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: "Add a comment",
                    suffixIcon: IconButton(
                      onPressed: () => addComment(),
                      icon: Icon(Icons.send),
                    ),
                  ),
                )
          ],
        ),
      );

      // return Padding(
      //   padding: EdgeInsets.only(
      //       top: 20,
      //       left: 20,
      //       right: 20,
      //       bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Center(
      //             child: Container(
      //               height: 3.0,
      //               width: 35,
      //               color: Colors.grey[700],
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 30,
      //           ),
      //           Center(
      //             child: Text(
      //               "Comments",
      //               style: TextStyle(fontWeight: FontWeight.bold),
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 15,
      //           ),
      //           Container(
      //             width: double.infinity,
      //             height: 1.0,
      //             color: Colors.grey,
      //           ),
      //           const SizedBox(
      //             height: 15,
      //           ),
      //           ListTile(
      //             leading: CircleAvatar(
      //               backgroundImage: AssetImage('assets/images/profile.png'),
      //             ),
      //             title: Text("User Name"),
      //             subtitle: Text("Nice picture"),
      //             trailing: Column(
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 IconButton(
      //                     onPressed: () {},
      //                     icon: Icon(Icons.favorite_border_rounded)),
      //               ],
      //             ),
      //           ),
      //           SizedBox(
      //             height: 10,
      //           ),
      //           Row(
      //             children: [
      //               SizedBox(
      //                 width: 75,
      //               ),
      //               Text("Reply"),
      //               SizedBox(
      //                 width: 25,
      //               ),
      //               Text("See translation"),
      //             ],
      //           )
      //         ],
      //       ),

      //      TextField(
      //       controller: commentController,
      //       decoration: InputDecoration(
      //         border: UnderlineInputBorder(),
      //         hintText: "Add a comment",
      //         suffixIcon: IconButton(onPressed: ()=>addComment(),icon: Icon(Icons.send),),

      //       ),

      //      )
      //     ],
      //   ),
      // );
    },
  );
}
