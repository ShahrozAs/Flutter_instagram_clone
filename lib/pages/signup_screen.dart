import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/my_button.dart';
import 'package:instagram_clone/components/my_textfield.dart';
import 'package:instagram_clone/helper/helper_functions.dart';
import 'package:instagram_clone/pages/login_page.dart';

class SignupScreen extends StatefulWidget {
  final void Function()? onTap;
  const SignupScreen({super.key, required this.onTap});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  void SignUp() async {
//Show Loading Cirecle
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

//show error Message if password not mach
    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      displayMessageToUser("Password not match", context);
    }
//try sign in User
    else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        //Create a User Document
        createUserDocument(userCredential);
        if (context.mounted) {
          Navigator.pop(context);
        }
        // Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessageToUser(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': nameController.text,
        'uid':userCredential.user!.uid,
      });
    }
  }

  // //wrong Email
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.background,
        // Adding gradient background to AppBar
      // Removing AppBar's shadow
      ),
      body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      const Text(
                        "English (US)",
                        style: TextStyle(color: Colors.black45),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Image.asset(
                          "assets/images/logo.webp",
                          width: 150,
                          height: 150,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                            top: 50,
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          child: MyTextField(
                            hintText: "Username",
                            obscureText: false,
                            controller: nameController,
                          )),
                      Container(
                          margin: const EdgeInsets.only(
                            top: 0,
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          child: MyTextField(
                            hintText: "Email",
                            obscureText: false,
                            controller: emailController,
                          )),
                      Container(
                          margin: const EdgeInsets.only(
                            top: 0,
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          child: MyTextField(
                              hintText: "Password",
                              obscureText: true,
                              controller: passwordController)),
                      Container(
                          margin: const EdgeInsets.only(
                            top: 0,
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          child: MyTextField(
                              hintText: "Confirm Password",
                              obscureText: true,
                              controller: confirmPasswordController)),
                      Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 20,
                          ),
                          child: MyButton(text: "Sign up", onTap: SignUp)),
                      // const Text(
                      //   "Already have account?",
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                          GestureDetector(
                        onTap: widget.onTap,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),border: Border.all(color: Colors.blue,width: 2)),
                            child: Center(child: Text("Already have an Account?",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue))),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/logo_meta.png",
                              width: 30,
                              height: 30,
                            ),
                            const Text(
                              "Meta",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
     
    );
  }
}
