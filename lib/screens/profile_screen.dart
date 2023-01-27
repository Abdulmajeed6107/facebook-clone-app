import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/controllers/signup_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:facebook_app/controllers/image_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {


      File? imageFile;
  File? coverFile;
  String imageUpdateKey = "imageUpdatekey";

  ///////////// Profile Image Method//////////////////////////
  pickUserProfileImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );
      if (croppedFile != null) {
        imageFile = File(croppedFile.path);
        debugPrint("image.path: ${image.path}");
        ([imageUpdateKey]);
        
        // uploadImagetoFirebasestorage(context);
        // Future uploadImagetoFirebasestorage(BuildContext context) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      final storageRef = FirebaseStorage.instance
          .ref()
          .child("UsersProfilePhoto/")
          .child("/$fileName");

      await storageRef.putFile(imageFile!);

      /////////////////////////////////Send image url to fireStore////////////////
      String imageUrl = await storageRef.getDownloadURL();
      User? user = FirebaseAuth.instance.currentUser;

      CollectionReference usersReference =
          FirebaseFirestore.instance.collection("users");
      String uid = "";
      debugPrint("uid:$uid");
      if (user != null) {
        uid = user.uid;
      }
      debugPrint("uid:$uid");
      try {
        DocumentReference currentUserReference = usersReference.doc(uid);
        await currentUserReference.update({"profileImageUrl": imageUrl});
        return true;
      } on Exception catch (e) {
        debugPrint(e.toString());
        return false;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    }
  }
      }
    }
  
  // Future uploadImagetoFirebasestorage(BuildContext context) async {
  //   try {
  //     String fileName = DateTime.now().millisecondsSinceEpoch.toString();

  //     final storageRef = FirebaseStorage.instance
  //         .ref()
  //         .child("UsersProfilePhoto/")
  //         .child("/$fileName");

  //     await storageRef.putFile(imageFile!);

  //     /////////////////////////////////Send image url to fireStore////////////////
  //     String imageUrl = await storageRef.getDownloadURL();
  //     User? user = FirebaseAuth.instance.currentUser;

  //     CollectionReference usersReference =
  //         FirebaseFirestore.instance.collection("users");
  //     String uid = "";
  //     debugPrint("uid:$uid");
  //     if (user != null) {
  //       uid = user.uid;
  //     }
  //     debugPrint("uid:$uid");
  //     try {
  //       DocumentReference currentUserReference = usersReference.doc(uid);
  //       await currentUserReference.update({"profileImageUrl": imageUrl});
  //       return true;
  //     } on Exception catch (e) {
  //       debugPrint(e.toString());
  //       return false;
  //     }
  //   } on FirebaseException catch (e) {
  //     debugPrint(e.message);
  //   }
  // }
    
    final UsersModel userdetail;
    CollectionReference userReference =
        FirebaseFirestore.instance.collection("user");
    User? currentUser = FirebaseAuth.instance.currentUser;

    // FutureBuilder<DocumentSnapshot>(
    //             future: userReference.doc(currentUser?.uid).get(),
    //             builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //               return ListView.builder(
    //                 // shrinkWrap: true,
    //                 // physics: ScrollPhysics(),
    //                 itemBuilder: (context, index) {
    //                   if (snapshot.hasData) {
    //                     Map<String, dynamic> data =
    //                         snapshot.data!.data() as Map<String, dynamic>;
    //                     UsersModel detail =
    //                         UsersModel.fromJson(snapshot.data!);
              
    //                     return ListTile(
    //                       title: Text(detail.metadata.name),
    //                       subtitle: Text(detail.metadata.email),
    //                       leading: Image.network(detail.metadata.profileImageUrl),
    //                     );
    //                   }
              
    //                   return Center(
    //                     child: CircularProgressIndicator(),
    //                   );
    //                 },
    //               );
    //             },
    //           );
    return GetBuilder<SignupScreenController>(
      init: SignupScreenController(),
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                  onPressed: () async {
                    await pickUserProfileImage(context);
                  },
                  child: Text(
                    "Post",
                    style: TextStyle(color: Colors.white),
                  )
                  )
            ],
            title: Text("Profile"),
          ),
          body: Column(
            children: [
              SizedBox(
                  child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    color: Colors.blue,
                  ),
                  Positioned(
                      bottom: 10,
                      right: -2,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Color(0xFFF5F6F9),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.blue,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      )),
                  CircleAvatar(radius: 50, backgroundColor: Colors.white),
                  Positioned(
                      top: 45,
                      left: 35,
                      child: RawMaterialButton(
                        onPressed: () {
                          // _.pickUserProfileImage(context);
                          // ClipOval;
                        },
                        elevation: 2.0,
                        fillColor: Color(0xFFF5F6F9),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.blue,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      )),
                  // _.imageFile != null
                  //     ? CircleAvatar(
                  //         radius: 80,
                  //         backgroundImage: AssetImage(
                  //           "asset/images/facebook.png",
                  //         ),
                  //         child: Image.file(
                  //           _.imageFile!,
                  //         ),
                  //       )
                  //     : Text(
                  //         "",
                  //       ),
                ],
              )
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 110,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(7)),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Add to Story",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ))),
                  Container(
                      width: 110,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7)),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ))),
                  Container(
                      width: 110,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7)),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "....",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ))),
                ],
              ),
              // FutureBuilder<DocumentSnapshot>(
              //   future: userReference.doc(currentUser!.uid).get(),
              //   builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              //     return ListView.builder(
              //       // shrinkWrap: true,
              //       // physics: ScrollPhysics(),
              //       itemBuilder: (context, index) {
              //         if (snapshot.hasData) {
              //           Map<String, dynamic> data =
              //               snapshot.data!.data() as Map<String, dynamic>;
              //           UsersModel detail =
              //               UsersModel.fromJson(data, snapshot.data!.id);
              
              //           return ListTile(
              //             title: Text(detail.name),
              //             subtitle: Text(detail.email),
              //             leading: Image.network(detail.profileImageUrl),
              //           );
              //         }
              
              //         return Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }
}
