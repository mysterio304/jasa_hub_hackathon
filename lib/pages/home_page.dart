import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon/models/usermodel.dart';
import 'package:hackathon/pages/login_page.dart';
import 'package:hackathon/widgets/contact_dialog.dart';
import 'package:hackathon/widgets/faq_dialog.dart';
import 'package:hackathon/widgets/filter_dialog.dart';
import 'package:hackathon/widgets/university_card.dart';
import 'package:hackathon/widgets/upcoming_event_card.dart';
import 'package:hackathon/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();
  TextEditingController searchController = TextEditingController();
  String university = '';

  @override
  void initState() {
    super.initState();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    firebaseFirestore.collection('users').doc(user!.uid).get().then((value){
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
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        title: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: TextFormField(
                controller: searchController,
                cursorColor: Colors.white,
                style: const TextStyle(fontSize: 20, color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Color.fromRGBO(95, 113, 135, 1), fontSize: 22),
                  border: InputBorder.none,
                ),
                onChanged: (val){
                  setState(() {
                    university = val;
                  });
                  displayUniversities();
                },
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: MediaQuery.of(context).size.height * 0.03),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.20,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(228, 223, 223, 1)),
                ),
                child: Row(
                  children: [
                    Ink(
                      decoration: const ShapeDecoration(
                        shape:  CircleBorder(),
                        color: Color.fromRGBO(95, 113, 135, 1),
                      ),
                      child: const Icon(Icons.filter_alt, color: Color.fromRGBO(228, 223, 223, 1), size: 20),
                    ),
                    const SizedBox(width: 2),
                    const Text('Filter', style: TextStyle(color: fontColor, fontSize: 12)),
                  ],
                ),
                onPressed: () {
                  showDialog(context: context, builder: (context) => Dialog(
                    child: FilterDialog(uid: userModel.uid!, favourite: userModel.favourite!),
                  ));
                },
              ),
            ),
          ),
        ],
        backgroundColor: const Color.fromRGBO(52, 72, 95, 1),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20)
          )
        ),
      ),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: MediaQuery.of(context).size.height * 0.07),
          child: Column(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Ink(
                  decoration: ShapeDecoration(
                    shape:  const CircleBorder(),
                    color: const Color.fromRGBO(95, 113, 135, 1).withOpacity(.5),
                  ),
                  child: const Icon(Icons.person, size: 40),
                ),
              ),
              const SizedBox(height: 10),
              Text(userModel.fullName!, style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500)),
              const SizedBox(height: 20),
              TextButton(
                child: Row(
                  children: const [
                    Icon(Icons.mail_outline, color: fontColor),
                    SizedBox(width: 5),
                    Text('Contact us', style: TextStyle(fontSize: 18, color: fontColor)),
                  ],
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const Dialog(
                      child: ContactDialog(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                child: Row(
                  children: const [
                    Icon(Icons.help_outline, color: fontColor),
                    SizedBox(width: 5),
                    Text('About', style: TextStyle(fontSize: 18, color: fontColor)),
                  ],
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const Dialog(
                      child: FaqDialog(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app, color: fontColor),
                    SizedBox(width: 5),
                    Text('Sign out', style: TextStyle(fontSize: 18, color: fontColor)),
                  ],
                ),
                onPressed: () {
                  logout(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: userModel.uid == null ? const Center(child: CircularProgressIndicator(color: fontColor)) : university != '' ? displayUniversities() : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Upcoming Events', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 20),
              Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: displayEvents()
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Career guidance', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(228, 223, 223, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Motivation letter samples', style: TextStyle(fontSize: 24, color: fontColor, fontWeight: FontWeight.w500)),
                        const Text('A motivation letter is a personal document detailing your professional skills and reasons for applying for a course of study, a scholarship or a volunteer job. ', style: TextStyle(color: fontColor)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(fontColor),
                            ),
                            onPressed: (){
                              downloadPDF('assets/MotivationPDF.pdf', 'MotivationPDF');
                            },
                            child: const Text('DOWNLOAD'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(228, 223, 223, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Recommendation letter samples', style: TextStyle(fontSize: 24, color: fontColor, fontWeight: FontWeight.w500)),
                        const Text('A formal letter that demonstrates the skills and performance of another person through the writer’s description of their professional, academic, or otherwise relevant experience with that person. ', style: TextStyle(color: fontColor)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(fontColor),
                            ),
                            onPressed: (){
                              downloadPDF('assets/RecommendationPDF.pdf', 'RecommendationPDF');
                            },
                            child: const Text('DOWNLOAD'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(228, 223, 223, 1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('CV', style: TextStyle(fontSize: 24, color: fontColor, fontWeight: FontWeight.w500)),
                        const Text("A CV (Curriculum Vitae) is a concise document that provides a summary of a person's education, work experience, skills, and achievements. It is commonly used for job applications, academic positions, and other professional opportunities. The CV highlights an individual's qualifications and serves as a tool for showcasing their suitability for a particular role or position.", style: TextStyle(color: fontColor)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(fontColor),
                            ),
                            onPressed: (){
                              downloadPDF('assets/CVPDF.pdf', 'CVPDF');
                            },
                            child: const Text('DOWNLOAD'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  displayEvents(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('events').snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return const Center(child: Text('No events'));
        }
        if(snapshot.data!.docs.isEmpty){
          return const Center(child: Text('No events'));
        }

        return(snapshot.connectionState == ConnectionState.waiting) ? const Center(child: CircularProgressIndicator()) : ListView.builder(
          itemCount: snapshot.data!.docs.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index){
            var data = snapshot.data!.docs[index].data();
            return UpcomingEventCard(
              url: data['url'],
              title: data['name'],
              cost: data['cost'],
              level: data['level'],
              type: data['type'],
              isOpen: data['isOpen'],
              day: data['date'].toString().substring(0, 2),
              month: data['date'].toString().substring(3, 5),
            );
          },
        );
      },
    );
  }

  displayUniversities(){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('universities').snapshots(),
      builder: (context, snapshot){
        return (snapshot.connectionState == ConnectionState.waiting) ? const Center(child: CircularProgressIndicator(color: fontColor)) :
          ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              var data = snapshot.data!.docs[index].data();
              if(university.isEmpty){
                return const Text('Is empty');
              }
              if(data['name'].toString().toLowerCase().startsWith(university.toLowerCase())){
                    return UniversityCard(
                      founded: data['founded'],
                      city: data['city'],
                      url: data['url'],
                      description: data['description'],
                      uid: userModel.uid!,
                      name: data['name'],
                      country: data['country'],
                      direction: data['direction'],
                      id: data['id'],
                      userFavouriteList: userModel.favourite!);
              } else{
                return Container();
              }
            },
          );
      },
    );
  }

  copyToClipboard(file){
    Clipboard.setData(ClipboardData(text: file == 1 ? 'https://sites.znu.edu.ua/international-relations/ELECTRA/MotivationPDF.pdf' : file == 2 ? 'https://gsi.berkeley.edu/media/sample-recommendation-letter.pdf' : 'https://www.yourspaceonline.net/uploads/sites/11/2021/05/Student_Graduate_CV.pdf')).then((value){
      Fluttertoast.showToast(msg: 'Copied!');
    });
  }

  Future<void> downloadPDF(pdfPath, fileName) async {
    try {
      final ByteData data = await rootBundle.load(pdfPath);
      final List<int> bytes = data.buffer.asUint8List();

      final String filePath = "/storage/emulated/0/Download/$fileName.pdf";


      final File file = File(filePath);
      await file.writeAsBytes(bytes);

      Fluttertoast.showToast(msg: 'PDF saved to Download folder!');
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    await FirebaseAuth.instance.signOut();
    nextScreenReplace(context, const LoginPage());
  }
}
