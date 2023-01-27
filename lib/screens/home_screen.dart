import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook_app/controllers/image_controller.dart';
import 'package:facebook_app/models/user_model.dart';
import 'package:facebook_app/screens/chat/chat.dart';
import 'package:facebook_app/screens/chat/rooms.dart';
import 'package:facebook_app/screens/chat/util.dart';
import 'package:facebook_app/screens/profile_screen.dart';
import 'package:facebook_app/screens/setting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    CollectionReference userReference =
        FirebaseFirestore.instance.collection("users");

    User? user = FirebaseAuth.instance.currentUser;
    if(user!=null){
    String userID = user.uid;
    }

    // return FutureBuilder(
    //   future: userReference.where("metadata.uid", isEqualTo: user!.uid).get(),
    //   builder: (context,snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return
    //           Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     } else if 
    //     (snapshot.connectionState == ConnectionState.done) {
         // UsersModel detail = UsersModel.fromJson(snapshot.data!.docs![Index]);
         return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                  // title: Text("Home"),
                  ),
              drawer: Drawer(
                  child: Column(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountEmail: Text('detail.metadata.phone'),
                    accountName: Text('detail.metadata.email'),
                    currentAccountPicture: CircleAvatar(
                        backgroundImage:
                            (NetworkImage('detail.metadata.profileImageUrl'))),
                  ),
                  ListTile(
                    title: const Text('Home'),
                    onTap: () {
                      Get.back();
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                    },
                  ),
                  ListTile(
                    title: const Text('Profile'),
                    onTap: () {
                      Get.to(ProfileScreen());
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                    },
                  ),
                  ListTile(
                    title: const Text('Chat'),
                    onTap: () {
                      Get.to(RoomsPage());
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                    },
                  ),
                  ListTile(
                    title: const Text('Setting'),
                    onTap: () {
                      Get.to(SettingScreen());
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                    },
                  ),
                ],
              )),
              body: FutureBuilder(
                //.where('metadata.uid',isEqualTo: user!.uid)
                future: userReference.where('metadata.uid', isEqualTo: user!.uid).get(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      UsersModel detail = UsersModel.fromJson(snapshot.data!.docs[index]);

                    return ListTile(
                      title: Text(detail.firstName),
                      subtitle: Text(detail.metadata.uid),
                    );
                  },);
                  }else{
                    return CircularProgressIndicator();
                  }
              },
              ),
        
              // body: GetBuilder<ImageController>(
              //     init: ImageController(),
              //     initState: (_) {},
              //     builder: (_) {
              //       return ListView.builder(
              //         itemCount: snapshot.data!.docs.length,
              //         itemBuilder: ((context, index) {
              //         return    Padding(
              //             padding: const EdgeInsets.all(16.0),
              //             child: Container(
              //               width: Get.width,
              //               child: Column(
              //                 children: [
              //                   Container(
              //                     height: 160.0,
              //                     child: Stack(
              //                       children: <Widget>[
              //                         Container(
              //                           color: Colors.white,
              //                           width:
              //                               MediaQuery.of(context).size.width,
              //                           height: 100.0,
              //                           child: Column(
              //                             children: [
              //                               Text(
              //                                 "facebook",
              //                                 style: TextStyle(
              //                                     color: Colors.blue,
              //                                     fontSize: 28.0,
              //                                     fontWeight: FontWeight.bold),
              //                               ),
              //                               Row(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.spaceEvenly,
              //                                 children: [
              //                                   IconButton(
              //                                     onPressed: () {
              //                                       Get.to(HomeScreen());
              //                                     },
              //                                     icon: Icon(Icons.home_filled),
              //                                     color: Colors.blue,
              //                                   ),
              //                                   IconButton(
              //                                       onPressed: () {
              //                                         Get.to(RoomsPage());
              //                                       },
              //                                       icon: Icon(Icons
              //                                           .chat_bubble_outline)),
              //                                   IconButton(
              //                                       onPressed: () {},
              //                                       icon: Icon(Icons
              //                                           .notifications_outlined)),
              //                                   IconButton(
              //                                       onPressed: () {
              //                                         var pickUserProfileImage =
              //                                             _.pickUserProfileImage(
              //                                                 context);
              //                                       },
              //                                       icon: Icon(Icons
              //                                           .camera_alt_outlined)),
              //                                 ],
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                         Positioned(
              //                           top: 80.0,
              //                           left: 0.0,
              //                           right: 0.0,
              //                           child: Container(
              //                             padding: EdgeInsets.symmetric(
              //                                 horizontal: 20.0),
              //                             child: DecoratedBox(
              //                               decoration: BoxDecoration(
              //                                   borderRadius:
              //                                       BorderRadius.circular(1.0),
              //                                   border: Border.all(
              //                                       color: Colors.grey
              //                                           .withOpacity(0.5),
              //                                       width: 1.0),
              //                                   color: Colors.white),
              //                               child: Row(
              //                                 children: [
              //                                   IconButton(
              //                                     icon: Icon(
              //                                       Icons.menu,
              //                                       color: Colors.red,
              //                                     ),
              //                                     onPressed: () {
              //                                       _scaffoldKey.currentState
              //                                           ?.openDrawer();
              //                                     },
              //                                   ),
              //                                   Expanded(
              //                                     child: TextField(
              //                                       decoration: InputDecoration(
              //                                         hintText: "Search",
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   IconButton(
              //                                     icon: Icon(
              //                                       Icons.search,
              //                                       color: Colors.red,
              //                                     ),
              //                                     onPressed: () {
              //                                       print(
              //                                           "your menu action here");
              //                                     },
              //                                   ),
              //                                   // IconButton(
              //                                   //   icon: Icon(
              //                                   //     Icons.notifications,
              //                                   //     color: Colors.red,
              //                                   //   ),
              //                                   //   onPressed: () {
              //                                   //     print("your menu action here");
              //                                   //   },
              //                                   // ),
              //                                 ],
              //                               ),
              //                             ),
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                   Row(
              //                     children: [
              //                       Container(
              //                         width: 70,
              //                         height: 70,
              //                         child: Image.network(
              //                             detail.metadata.profileImageUrl),
              //                         decoration: BoxDecoration(
              //                           color: Colors.red,
              //                           shape: BoxShape.circle,
              //                         ),
              //                       ),
              //                       SizedBox(
              //                         width: 15,
              //                       ),
              //                       Column(
              //                         crossAxisAlignment:
              //                             CrossAxisAlignment.start,
              //                         children: [
              //                           Text(''),
              //                           Text(
              //                             "12.00",
              //                           ),
              //                         ],
              //                       ),
              //                       SizedBox(
              //                         width: 110,
              //                       ),
              //                       IconButton(
              //                           onPressed: () {},
              //                           icon: Icon(Icons.share))
              //                     ],
              //                   ),
              //                   SizedBox(
              //                     height: 10,
              //                   ),
              //                   Text(
              //                       "this is the way this is the way this is the way this is the way this is the way this is the way this is the way this is the way "),
              //                   SizedBox(
              //                     height: 10,
              //                   ),

//                     Container(
//   width: 100,
//   height: 100,
//   decoration: BoxDecoration(
//     image: DecorationImage(
//       image: NetworkImage(imageUrl),
//       fit: BoxFit.cover,
//     ),
//     borderRadius: BorderRadius.all(
//       Radius.circular(50.0),
//     ),
//     boxShadow: [
//       BoxShadow(blurRadius: 10, color: Colors.black)
//     ],
//   ),
// ),
        //                         if (_.imageFile != null)
        //                           Container(
        //                             width: 100,
        //                             height: 100,
        //                           ),

        //                         Row(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             IconButton(
        //                               onPressed: () {},
        //                               icon: Icon(Icons.thumb_up_alt_outlined),
        //                             ),
        //                             IconButton(
        //                                 onPressed: () {},
        //                                 icon: (Icon(Icons.share_outlined))),
        //                             IconButton(
        //                                 onPressed: () {},
        //                                 icon: Icon(Icons.messenger_outline)),
        //                           ],
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 );
        //               }),
        //               // children: [
                     
                      
        //             );
        //           }));
        // }

        // return Text("data no find");
    
          );
        
   
  //  } else{
  //   return Scaffold(
  //     body: CircularProgressIndicator(),
  //   );
  //  } 
   
  //  }
  

  //  );
  
  }
  
  }