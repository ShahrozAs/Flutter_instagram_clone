import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/create_bottomsheetComments.dart';
import 'package:instagram_clone/components/full_image.dart';
import 'package:instagram_clone/components/like_button.dart';
import 'package:instagram_clone/helper/helper_functions.dart';
import 'package:instagram_clone/helper/resources.dart';
import 'package:instagram_clone/pages/search_page.dart';
import 'package:instagram_clone/pages/uploadPost_page.dart';
import 'package:instagram_clone/pages/upload_image.dart';
import 'package:instagram_clone/pages/profile_page.dart';

const String homeScreenRoute = '/';
const String searchScreenRoute = '/search';
const String uploadScreenRoute = '/upload';
const String videosScreenRoute = '/videos';
const String profileScreenRoute = '/profile';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, bool> likedPosts = {};
  Map<String, int> likeCounts = {};
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  bool isLiked = false;
  //  bool isLiked = false;

  // ... (other methods remain the same)

  Future<void> toggleLike(String postId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final postRef =
          FirebaseFirestore.instance.collection('UsersPost').doc(postId);

      final likeRef = postRef.collection('likes').doc(user.uid);
      final doc = await likeRef.get();

      if (doc.exists) {
        // User already liked the post, so unlike it
        await likeRef.delete();
        setState(() {
          likedPosts[postId] = false; // Update the liked status in the map
        });
      } else {
        // User hasn't liked the post, so like it
        await likeRef.set({'liked': true});
        setState(() {
          likedPosts[postId] = true; // Update the liked status in the map
        });
      }
    }
  }

  Future<int> getLikeCount(String postId) async {
    final postRef =
        FirebaseFirestore.instance.collection('UsersPost').doc(postId);
    final likesSnapshot = await postRef.collection('likes').get();
    return likesSnapshot.size; // Return the count of likes for the post
  }

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
       // Making AppBar transparent

        title: Row(
          children: [
            Image.network(
              "https://th.bing.com/th/id/R.825e4d7b40faa8f9c51da0c73d6254d8?rik=RVfV80ATb%2boUhg&pid=ImgRaw&r=0",
              width: 110,
              height: 100,
            ),
            Icon(Icons.keyboard_arrow_down_sharp),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Implement action (e.g., Search functionality)
            },
            icon: Icon(Icons.favorite_border_rounded, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.network(
              "https://th.bing.com/th/id/OIP.Kb8XWL899wpZKDS8LosySgHaHk?rs=1&pid=ImgDetMain",
              width: 20,
            ),
          ),
          
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('UsersPost')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            displayMessageToUser("Something went wrong", context);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(),
            );
          }
          if (snapshot.data == null) {
            return Center(
              child: Text("No data found"),
            );
          }

          final users = snapshot.data!.docs;
          return Container(
            child: ListView.builder(
              itemCount: users.length, // Replace with actual post count
              itemBuilder: (context, index) {
                final user = users[index];
                final docId = user.id;

                return FutureBuilder<int>(
                    future: getLikeCount(docId),
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Return a placeholder while fetching like count
                        return Container();
                      } else if (snapshot.hasError) {
                        // Handle error fetching like count
                        return Text('Error fetching likes');
                      } else {
                        // Store like count in the map
                        likeCounts[docId] = snapshot.data ?? 0;

                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        FullImagePreview(
                                                            imageUrl: user[
                                                                'userImage']),
                                                  ));
                                            },
                                            child: CircleAvatar(
                                              radius: 20,
                                              // Replace with user's profile image
                                              backgroundImage: NetworkImage(
                                                  '${user['userImage'] != null ? user['userImage'] : "https://www.moroccoupclose.com/uwagreec/2018/12/default_avatar-2048x2048.png"}'),
                                            ),
                                          ),
                                          SizedBox(width: 8.0),
                                          Text(
                                            user['name'] != null
                                                ? user['name']
                                                : "user",
                                            // user['username'],
                                            // ''+user.email!, // Replace with user's username
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.more_vert_outlined),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(user['caption'] != null
                                      ? user['caption']
                                      : " "),
                                ),
                                // Replace with post image
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullImagePreview(
                                                    imageUrl:
                                                        user['imageLink']),
                                          ));
                                    },
                                    child: Image.network(
                                      '${user['imageLink']}',
                                      fit: BoxFit.contain,
                                      width: null,
                                      height: null,
                                    )),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Row(children: [
                                              // LikeButton(isLiked: isLiked, onTap: ()async{await toggleLike(docId);}),
                                              LikeButton(
                                                isLiked: likedPosts
                                                        .containsKey(docId)
                                                    ? likedPosts[docId]!
                                                    : false,
                                                onTap: () async {
                                                  await toggleLike(docId);
                                                },
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  // String resp=await storeData().saveCommentData (docId: docId);
                                                  createBottomSheetComments(
                                                      context,
                                                      user['name'],
                                                      docId);
                                                },
                                                icon: Icon(
                                                    Icons.comment_outlined),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  // Implement share functionality
                                                },
                                                icon: Icon(Icons.send),
                                              ),
                                            ]),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              // Implement save functionality
                                            },
                                            icon: Icon(Icons.bookmark_border),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        '${likeCounts[docId]} likes',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4.0),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 12,
                                            // Replace with comment user's profile image
                                            backgroundImage: AssetImage(
                                                'assets/images/profile.png'),
                                          ),
                                          SizedBox(width: 8.0),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'CommentUsername', // Replace with comment user's username
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'This is a comment', // Replace with comment text
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'View all 10 comments', // Replace with comment count
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Posted on 21 Dec 2023', // Replace with post date
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xffFD1D59),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_collection),
            label: 'Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],

        currentIndex: 0, // Set the initial index to Home
        onTap: (index) {
          // Handle navigation on item tap
          switch (index) {
            case 0:
              Navigator.pushNamed(context, homeScreenRoute);
              break;
            case 1:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ));
              // Navigator.pushNamed(context, searchScreenRoute);
              break;
            case 2:
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadPostPage(),
                  ));
              // Navigator.pushNamed(context, uploadScreenRoute);
              break;
            case 3:
              Navigator.pushNamed(context, videosScreenRoute);
              break;
            case 4:
              // Navigator.pushNamed(context, profileScreenRoute);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ));
              break;
          }
        },
      ),
    );
  }
}
