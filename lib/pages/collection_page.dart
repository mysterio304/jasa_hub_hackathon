import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/models/usermodel.dart';
import 'package:hackathon/widgets/university_card.dart';
import 'package:hackathon/widgets/widgets.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {

  UserModel user = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection('users').doc(widget.uid).get().then((value){
      setState(() {
        user = UserModel.fromMap(value.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(95, 113, 135, 1),
      appBar: AppBar(
        title: const Text('Collection', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
        backgroundColor: const Color.fromRGBO(95, 113, 135, 1),
        elevation: 0,
      ),
      body: user.uid == null ? const Center(child: CircularProgressIndicator(color: fontColor)) : showFavouriteList(),
    );
  }

  showFavouriteList(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('universities').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return const Center(child: Text('Collection is empty'));
        }
        if(snapshot.data!.docs.isEmpty){
          return const Center(child: Text('Collection is empty'));
        }

        final filteredDocs = snapshot.data!.docs.where((element) => user.favourite!.contains(element.id)).toList();

        return(snapshot.connectionState == ConnectionState.waiting) ? const Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: filteredDocs.length,
          itemBuilder: (BuildContext context, int index){
            return UniversityCard(description: filteredDocs[index]['description'], city: filteredDocs[index]['city'], founded: filteredDocs[index]['founded'], uid: user.uid!, id: filteredDocs[index]['id'], name: filteredDocs[index]['name'], country: filteredDocs[index]['country'], direction: filteredDocs[index]['direction'], userFavouriteList: user.favourite!, url: filteredDocs[index]['url']);
          },
        );
      },
    );
  }
}