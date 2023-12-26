import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/helper/resources.dart';
import 'package:instagram_clone/pages/upload_image.dart';

// Other necessary imports for image picker, storage, network, etc.

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Variables to store profile data from state management
  String profileImagePath = "";
  String username = "";
  String name = "";
  String website = "";
  String bio = "";
  String pronouns = "";
  String gender = "";

  // // Function to handle image selection
  // Future<void> pickImage() async {
  //   // Implement image picker functionality
  // }

  // Function to handle profile update
  // Future<void> updateProfile() async {
  //   // Implement profile update logic with server/database
  // }

  void saveProfile()async{
    showDialog(context: context, builder: (context) {
      return const Center(child: AlertDialog(actions: [Center(child: CircularProgressIndicator()),],title: Center(child: Text("Saving.."))),);
    },);
    String resp=await storeData().saveData(name: name, username: username, bio: bio, file: _image!);


     Navigator.pop(context);
  }

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Profile picture widget with image selection
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: selectImage,
                    child: _image != null
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: MemoryImage(
                                (_image!),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              radius: 50,
                              foregroundImage: AssetImage(
                                "assets/images/profile.png",
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: profileImagePath.isNotEmpty
                        ? FileImage(File(profileImagePath))
                        : null,
                    child: IconButton(
                      icon: Icon(Icons.face_retouching_natural_outlined),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              Center(
                child: Text(
                  "Edit picture or avatar",
                  style: TextStyle(fontSize: 15, color: Colors.blue[500]),
                ),
              ),
              SizedBox(height: 20),
              // Text fields for name, username, website, bio, and pronouns
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => setState(() => name = value),
              ),
              TextFormField(
                initialValue: username,
                decoration: InputDecoration(labelText: 'Username'),
                onChanged: (value) => setState(() => username = value),
              ),
              TextFormField(
                initialValue: website,
                decoration: InputDecoration(labelText: 'Website'),
                onChanged: (value) => setState(() => website = value),
              ),
              TextFormField(
                initialValue: bio,
                decoration: InputDecoration(labelText: 'Bio'),
                onChanged: (value) => setState(() => bio = value),
                maxLines: 5, // Allow multiple lines for bio
              ),
              TextFormField(
                initialValue: pronouns,
                decoration: InputDecoration(labelText: 'Pronouns (optional)'),
                onChanged: (value) => setState(() => pronouns = value),
              ),
              // Gender selection
              Row(
                children: [
                  Text('Gender:'),
                  SizedBox(width: 10),
                  // Radio buttons for common options
                  Row(
                    children: [
                      Radio<String>(
                        value: 'male',
                        groupValue: gender,
                        onChanged: (value) => setState(() => gender = value!),
                      ),
                      Text('Male'),
                      SizedBox(width: 10),
                      Radio<String>(
                        value: 'female',
                        groupValue: gender,
                        onChanged: (value) => setState(() => gender = value!),
                      ),
                      Text('Female'),
                    ],
                  ),
                  // Additional option for custom gender
                  Radio<String>(
                    value: 'other',
                    groupValue: gender,
                    onChanged: (value) => setState(() => gender = value!),
                  ),
                  Text('Other'),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: saveProfile,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Save'),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
