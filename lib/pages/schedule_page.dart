import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/widgets/add_todo.dart';
import 'package:hackathon/widgets/todo_card.dart';
import 'package:hackathon/widgets/widgets.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {

  User? user = FirebaseAuth.instance.currentUser;

  TabBar get _tabBar => const TabBar(
    labelColor: Colors.white,
    overlayColor: MaterialStatePropertyAll(fontColor),
    indicatorColor: fontColor,
    tabs: [
      Tab(text: 'CURRENT EVENTS'),
      Tab(text: 'PAST EVENTS'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(95, 113, 135, 1),
        appBar: AppBar(
          title: const Text('Schedule', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
          backgroundColor: fontColor.withOpacity(0.3),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              color: Colors.white,
              onPressed: () {
                showAddDialog();
              },
            ),
          ],
          elevation: 0,
          bottom: _tabBar,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child:
          TabBarView(
            children: [
              showActive(),
              showDone(),
            ],
          ),
        ),
      ),
    );
  }

  showAddDialog(){
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: AddTodo(uid: user!.uid),
      )
    );
  }
  
  showActive(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('todos').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return const Center(child: Text('No Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)));
        }
        if(snapshot.data!.docs.isEmpty){
          return const Center(child: Text('No Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)));
        }

        final filteredDocs = snapshot.data!.docs.where((element) => element.get('done') == false).toList();

        return(snapshot.connectionState == ConnectionState.waiting) ? const Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: filteredDocs.length,
          itemBuilder: (BuildContext context, int index){
            return TodoCard(start: filteredDocs[index]['start'], done: false, id: filteredDocs[index]['id'], title: filteredDocs[index]['title'], description: filteredDocs[index]['description'], uid: user!.uid);
          },
        );
      },
    );
  }

  showDone(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).collection('todos').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return const Center(child: Text('No Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)));
        }
        if(snapshot.data!.docs.isEmpty){
          return const Center(child: Text('No Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)));
        }

        final filteredDocs = snapshot.data!.docs.where((element) => element.get('done') == true).toList();

        return(snapshot.connectionState == ConnectionState.waiting) ? const Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: filteredDocs.length,
          itemBuilder: (BuildContext context, int index){
            return TodoCard(start: filteredDocs[index]['start'], end: filteredDocs[index]['end'], done: true, id: filteredDocs[index]['id'], title: filteredDocs[index]['title'], description: filteredDocs[index]['description'], uid: user!.uid);
          },
        );
      },
    );
  }
}