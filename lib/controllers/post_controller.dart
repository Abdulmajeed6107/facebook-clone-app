// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:facebook_app/models/post_models.dart';
// import 'package:facebook_app/models/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class PostController extends GetxController{
//  TextEditingController bodycontroller = TextEditingController();

//  UsersModel? userModel;
// List<PostModel> dataModel = [];
// String userName = "";
// String? userImage; 
// CollectionReference userRefrence = FirebaseFirestore .instance.collection("users");
// User? user = FirebaseAuth.instance.currentUser;

// File? imageFile;
// final ImagePicker imagePicker = ImagePicker();
// get firebasestorage => null;

// addpost() async{
//   CollectionReference postReference = FirebaseFirestore.instance.collection("users");
//   User? user = FirebaseAuth.instance.currentUser;
//   String uid = "";

//   if(user !=null){
//     uid = user.uid;
//   }
//   String body = bodycontroller.text;

//   DateTime now = DateTime.now();
//   var doc = FirebaseFirestore.instance.collection("users");

// }
// final data = {
//   "postText": body,
//   "uid": uid,
//   "dateTime": DateTime.now(),
//   "userImage": userImage,
//   "userName": userName,
// };
//  doc.add(data).then(Value) => Get.snackbar("Add post successfully", "").catche;


// }