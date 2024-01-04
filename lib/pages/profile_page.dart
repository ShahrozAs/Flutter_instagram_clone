import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/components/create_bottomsheet.dart';
import 'package:instagram_clone/helper/checkpost.dart';
import 'package:instagram_clone/pages/editProfile_page.dart';
import 'package:instagram_clone/pages/home_page.dart';
import 'package:instagram_clone/pages/search_page.dart';
import 'package:instagram_clone/pages/uploadPost_page.dart';
import 'package:instagram_clone/pages/upload_image.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? currentUser = FirebaseAuth.instance.currentUser!;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }

 Uint8List?  _image;

  void selectImage()async{
    Uint8List img=await pickImage(ImageSource.gallery);
    setState(() {
      
    _image=img;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(
      //         child: Row(
      //           children: [
      //             IconButton(
      //               onPressed: () {},
      //               icon: Icon(
      //                 Icons.lock_outline_sharp,
      //                 size: 20,
      //                 weight: 100,
      //                 color: Colors.black,
      //               ),
      //             ),
      //             Text(
      //               "mrsherry_03",
      //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      //             ),
      //             Icon(Icons.keyboard_arrow_down_sharp),
      //           ],
      //         ),
      //       ),
      //       Container(
      //         child: Row(
      //           children: [
      //             IconButton(
      //                 onPressed: () {}, icon: Icon(Icons.add_box_outlined)),
      //             IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      body: Padding(
          padding: const EdgeInsets.only(top:10.0),
          child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                return Column(
                  children: [
                    Container(
                      color: Colors.white,
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.lock_outline_sharp,
                                    size: 20,
                                    weight: 100,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                   user?['username']??"username",
                                  // user!['username'],
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w700),
                                ),
                                Icon(Icons.keyboard_arrow_down_sharp),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.add_box_outlined)),
                                IconButton(
                                    onPressed: ()=>createBottomSheet(context), icon: Icon(Icons.menu)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: selectImage,
                                    child: _image!=null? Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: MemoryImage(
                                          (_image!),
                                       
                                        ),
                                      ),
                                    ):Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: CircleAvatar(
                                        radius: 50,
                                        foregroundImage: NetworkImage(
                                           '${user?['imageLink']??"https://www.moroccoupclose.com/uwagreec/2018/12/default_avatar-2048x2048.png"}'
                                          //  "${user['imageLink']}"
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "6",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        "Posts",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "169",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "97",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        "Following",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
          
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:10.0),
                                          child: Text(
                                          user?['name']??"Name",
                                            style: TextStyle(
                                                fontSize: 12.5,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
          
                                      IconButton(onPressed: (){
          
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfilePage(),));
          
                                      }, icon: Icon(Icons.edit)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                                    children: [
          
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:10.0),
                                          child: Text(
                                            // "yuio",
                                              user?['bio']??"bio",
                                            style: TextStyle(
                                                fontSize: 12.5,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      IconButton(onPressed: (){
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfilePage(),));
          
          
                                      }, icon: Icon(Icons.edit)),
          
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width * 0.35,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 230, 230, 230),
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfilePage(),));
                                          },
                                          child: Text(
                                            "Edit profile",
                                            style: TextStyle(color: Colors.black),
                                          )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      width:
                                          MediaQuery.of(context).size.width * 0.35,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 230, 230, 230),
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => ShowPost(userName: user?['username']??""),));
                                          },
                                          child: Text(
                                            "Share profile",
                                            style: TextStyle(color: Colors.black),
                                          )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      width:
                                          MediaQuery.of(context).size.width * 0.10,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 230, 230, 230),
                                      ),
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                              Icons.person_add_alt_1_outlined)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.grid_on_outlined)),
                                      Image.asset(
                                        'assets/images/person_square.png',
                                        width: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(0),child: ShowPost(userName: user?['username']??""),),
        
                            ]),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text("No Data Found"),
                );
              }
            },
          ),
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

        currentIndex: 4, // Set the initial index to Home
        onTap: (index) {
          // Handle navigation on item tap
          switch (index) {
            case 0:
           Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ));
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
              // Navigator.pushNamed(context, videosScreenRoute);
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
