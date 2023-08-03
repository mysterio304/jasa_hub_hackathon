import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/models/usermodel.dart';
import 'package:hackathon/pages/collection_page.dart';
import 'package:hackathon/pages/home_page.dart';
import 'package:hackathon/pages/profile_page.dart';
import 'package:hackathon/pages/schedule_page.dart';
import 'package:hackathon/widgets/widgets.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;


  User? user = FirebaseAuth.instance.currentUser;
  // UserModel userModel = UserModel();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   firebaseFirestore.collection('users').doc(user!.uid).get().then((value){
  //     setState(() {
  //       userModel = UserModel.fromMap(value.data());
  //     });
  //   });
  // }

  void onTabTapped(int index){
    if(_currentIndex == index) return;
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [
      HomePage(),
      SchedulePage(),
      CollectionPage(uid: user!.uid),
      ProfilePage(uid: user!.uid),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: const Color.fromRGBO(228, 223, 223, 1),
        unselectedItemColor: Colors.grey[500],
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Collection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: bottomBarIconColor,
      ),
      body: Center(
        child: _children[_currentIndex],
      ),
    );
  }
}
