
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/components/my_button.dart';
import 'package:instagram_clone/components/my_textfield.dart';
import 'package:instagram_clone/helper/helper_functions.dart';
import 'package:instagram_clone/pages/signup_screen.dart';



class LoginScreen extends StatefulWidget {
   final void Function()? onTap;
  LoginScreen({super.key,required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
void Login()async{

showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),));

try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

  if (context.mounted) {
    Navigator.pop(context);
  }
}on FirebaseAuthException catch (e) {
    Navigator.pop(context);
  displayMessageToUser(e.code, context);
}

}
  // //wrong Email
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.background,
        // Adding gradient background to AppBar
        backgroundColor: Colors.transparent, // Making AppBar transparent
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(254, 249, 243, 1),
                Color.fromRGBO(235, 243, 254, 1),
                Color.fromRGBO(238, 251, 242, 1),
              ],
              stops: [0.0, 0.35, 1.0],
            ),
          ),
        ),
        elevation: 0, // Removing AppBar's shadow
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromRGBO(254, 249, 243, 1),
              Color.fromRGBO(235, 243, 254, 1),
              Color.fromRGBO(238, 251, 242, 1),
            ],
            stops: [0.0, 0.35, 1.0],
          ),
        ),
        child: Center(
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
                      child: MyTextField(hintText: "Username,email or mobile number",obscureText: false,controller: emailController,)
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 0,
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      child: MyTextField(hintText: "Password", obscureText: true, controller: passwordController)
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child:MyButton(text: "Login", onTap: Login)
                    ),
                    const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Color.fromRGBO(0, 100, 224, 1),
                          width: 2,
                        ),
                      ),
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: GestureDetector(
                        onTap: widget.onTap,
                        child: Container(
                          decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.white)),
                          height: 50,
                          child: Card(
                            borderOnForeground: false,

                            elevation: 1,
                            child: Center(child: Text("Create new Account?")),
                          ),
                        )
                          
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
      ),
    );
  }
}

