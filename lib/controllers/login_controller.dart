import 'package:facebook_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/firebase_authentication.dart';
import '../screens/profile_screen.dart';
class LoginScreenController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final String hintEmail = "Pleas type your Email";
  final String hintPassword = "Pleas type your password";

   bool status = false;

   String? validateEmail(String? value){
    if(value == null){
      return "please enter your email";
    }
    if(!GetUtils.isEmail(value)){
        return "Enter your valid email";
    }
    return null;
    }

    String? validatePassword(String? value){
      if(value == null || value.isEmpty){
        return "enter your password";
      } else if(value.length<8){
        return " enter valid password";
      }
      return null;
    }
    
    onsigninUser()async{
      status=await Auth.signinUser(email: emailController.text, 
      passowrd: passwordController.text);

       status? Get.to(HomeScreen()):
       print("Error");
}
    
    
}