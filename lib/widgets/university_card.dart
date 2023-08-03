import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon/pages/university_page.dart';
import 'package:hackathon/widgets/widgets.dart';

class UniversityCard extends StatefulWidget {
  const UniversityCard({Key? key, required this.description, required this.city, required this.founded, required this.url, required this.uid, required this.id,  required this.name, required this.country, required this.direction, required this.userFavouriteList}) : super(key: key);

  final String description;
  final String id;
  final String uid;
  final String name;
  final String country;
  final String direction;
  final String city;
  final String founded;
  final String url;
  final List userFavouriteList;

  @override
  State<UniversityCard> createState() => _UniversityCardState();
}

class _UniversityCardState extends State<UniversityCard> {

  bool isRed = false;

  @override
  void initState() {
    super.initState();
    if(widget.userFavouriteList.contains(widget.id)){
      setState(() {
        isRed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context, UniversityPage(univer: {
          'id': widget.id,
          'country': widget.country,
          'direction': widget.direction,
          'city': widget.city,
          'founded': widget.founded,
          'name': widget.name,
          'url': widget.url,
          'description': widget.description,
        }));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.25,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(228, 223, 223, 1),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.height * 0.20,
                height: MediaQuery.of(context).size.height * 0.20,
                color: Colors.grey,
                child: widget.url == '' ? const Center(child: Text('No photo', style: TextStyle(fontSize: 18, color: Colors.white))) : Image.network(widget.url, fit: BoxFit.fill,),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.direction, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: fontColor)),
                    const SizedBox(height: 10),
                    Text(widget.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: fontColor)),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey[700]),
                        Text(widget.country, style: const TextStyle(fontSize: 16, color: fontColor)),
                        const Spacer(),
                        IconButton(
                          icon: isRed ? const Icon(Icons.favorite, color: Colors.red) : const Icon(Icons.favorite_outline),
                          onPressed: () {
                            addFavourite(widget.id);
                            setState(() {
                              isRed = !isRed;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addFavourite(id){
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    if(!isRed){
      firebaseFirestore.collection('users').doc(widget.uid).update({
        'favourite': FieldValue.arrayUnion([id])
      });
      Fluttertoast.showToast(msg: 'Added!');
    } else{
      firebaseFirestore.collection('users').doc(widget.uid).update({
        'favourite': FieldValue .arrayRemove([id]),
      });
      Fluttertoast.showToast(msg: 'Deleted!');
    }
  }
}
