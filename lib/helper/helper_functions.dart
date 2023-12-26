import 'package:flutter/material.dart';

//Show error Messages

void displayMessageToUser(String message,BuildContext context){
  showDialog(context: context, builder: (context) => AlertDialog(title: Text(message),),);

}