import 'package:facebook_app/screens/chat/rooms.dart';
import 'package:flutter/material.dart';


class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}


class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {

  int selectedIndex = 0;
  List<Widget> bodyList=[
    RoomsPage(),
    ListView.builder(
      itemCount: 100,
      itemBuilder: (BuildContext context, int index) {
        return Text("status");
      },
    ),
ListView.builder(
  itemCount: 100,
  itemBuilder: (BuildContext context, int index) {
    return Text("call");
  },
),
    Center(child: Text("Index==3"),),
  ];
  void _onNavBarTapped(int currentIndex) {
     selectedIndex = currentIndex;
       setState(() {
         
       });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Whatsapp"),),
      body: bodyList.elementAt(selectedIndex),
      bottomNavigationBar:BottomNavigationBar(
        items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Star"),
          BottomNavigationBarItem(icon: Icon(Icons.build_circle), label: "build.circle"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "School"),
        ],
        currentIndex: selectedIndex,

        onTap: _onNavBarTapped,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.cyan,
      ),

    );
  }
}