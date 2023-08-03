import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/models/usermodel.dart';
import 'package:hackathon/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  UserModel userModel = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection('users').doc(widget.uid).get().then((value){
      setState(() {
        userModel = UserModel.fromMap(value.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(95, 113, 135, 1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(95, 113, 135, 1),
        title: const Text('Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
      ),
      body: userModel.uid == null ? Center(child: CircularProgressIndicator(color: fontColor)) : Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 120,
                height: 120,
                child: Ink(
                  decoration: const ShapeDecoration(
                    shape: CircleBorder(),
                    color: Color.fromRGBO(228, 223, 223, 1),
                  ),
                  child: const Icon(Icons.person, size: 80, color: fontColor),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text('Full name: ${userModel.fullName!}', style: const TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 10),
            Text('Email: ${userModel.email!}', style: const TextStyle(fontSize: 18, color: Colors.white)),
            const SizedBox(height: 10),
            Text('ID: ${userModel.uid!}', style: const TextStyle(fontSize: 18, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
