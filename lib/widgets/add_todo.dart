import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon/widgets/custom_button.dart';
import 'package:hackathon/widgets/custom_textfield.dart';

class AddTodo extends StatelessWidget {
  AddTodo({Key? key, required this.uid}) : super(key: key);

  final String uid;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(95, 113, 135, 1),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add ToDo', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)),
            const SizedBox(height: 30),
            CustomTextField(hint: 'Title', icon: const Icon(Icons.title), controller: titleController),
            const SizedBox(height: 30),
            CustomTextField(hint: 'Description', icon: const Icon(Icons.description), controller: descriptionController),
            const SizedBox(height: 30),
            CustomButton(label: 'Add', onPressed: () {
              addTodo(context);
            }),
          ],
        ),
      ),
    );
  }

  addTodo(context) async{
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day, now.hour, now.minute);

    if(titleController.text.isNotEmpty && descriptionController.text.isNotEmpty){
      CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').doc(uid).collection('todos');
      DocumentReference documentReference = await collectionReference.add({
        'title': titleController.text,
        'description': descriptionController.text,
        'done': false,
        'id': '',
        'start': date.toString().substring(0, 16),
        'end': '',
      });

      String docId = documentReference.id;
      await documentReference.update({
        'id': docId,
      });

      Fluttertoast.showToast(msg: 'Added!');
    } else{
      Fluttertoast.showToast(msg: 'The fields are empty!');
    }
  }

}