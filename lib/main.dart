import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/pages/login_page.dart';
import 'package:hackathon/pages/main_page.dart';
import 'package:hackathon/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // если пользователь заходит с браузера
  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId,
            storageBucket: Constants.storageBucket,
        ));
  }
  else{
    await Firebase.initializeApp();
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(MaterialApp(
      theme: ThemeData(primaryColor: const Color.fromRGBO(189, 188, 252, 1)),
      debugShowCheckedModeBanner: false,
      home: email == null ? const LoginPage() : MainPage()));
}