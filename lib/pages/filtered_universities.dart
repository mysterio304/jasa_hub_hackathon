import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/widgets/university_card.dart';
import 'package:hackathon/widgets/widgets.dart';

class SortedUniversitiesPage extends StatefulWidget {
  const SortedUniversitiesPage({Key? key, required this.uid, required this.favourite, required this.country, required this.direction}) : super(key: key);

  final String uid;
  final List favourite;
  final String country;
  final String direction;

  @override
  State<SortedUniversitiesPage> createState() => _SortedUniversitiesPageState();
}

class _SortedUniversitiesPageState extends State<SortedUniversitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(95, 113, 135, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(95, 113, 135, 1),
        title: const Text('Filter', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: displayFilteredUniversities(),
    );
  }

  displayFilteredUniversities() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('universities').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(child: Text('Empty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)));
        }
        return (snapshot.connectionState == ConnectionState.waiting) ? const Center(child: CircularProgressIndicator(color: fontColor)) :
        ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index){
            var data = snapshot.data!.docs[index].data();
            if((data['country'] == widget.country || widget.country == 'All') && (data['direction'] == widget.direction || widget.direction == 'All')){
              return UniversityCard(
                  founded: data['founded'],
                  city: data['city'],
                  url: data['url'],
                  description: data['description'],
                  uid: widget.uid,
                  name: data['name'],
                  country: data['country'],
                  direction: data['direction'],
                  id: data['id'],
                  userFavouriteList: widget.favourite);
            } else{
              return Container();
            }
          },
        );
      },
    );
  }

}
