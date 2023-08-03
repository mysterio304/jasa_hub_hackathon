import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon/widgets/custom_button.dart';
import 'package:hackathon/widgets/widgets.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({Key? key, required this.done, required this.id, required this.title, required this.description, required this.uid, required this.start, this.end}) : super(key: key);

  final String title;
  final String description;
  final String uid;
  final String id;
  final bool done;
  final String start;
  final String? end;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(228, 223, 223, 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 22, color: fontColor)),
            const SizedBox(height: 10),
            Text(description, style: const TextStyle(fontSize: 18, color: fontColor)),
            const SizedBox(height: 10),
            done ? Text('Started: $start\nEnded: $end', style: const TextStyle(fontSize: 18, color: fontColor)) : Text('Started: $start', style: const TextStyle(fontSize: 18, color: fontColor)),
            const SizedBox(height: 10),
            done ? const Text('DONE', style: TextStyle(fontSize: 22, color: Colors.green, fontWeight: FontWeight.w600)) : CustomButton(label: 'COMPLETE', height: 40, onPressed: () {
              completeTodo(id);
            }),
          ],
        ),
      ),
    );
  }

  completeTodo(id) async{
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    await firebaseFirestore.collection('users').doc(uid).collection('todos').doc(id).update({
      'done': true,
      'end': date.toString().substring(0, 16),
    });
    Fluttertoast.showToast(msg: 'Completed!');
  }
}