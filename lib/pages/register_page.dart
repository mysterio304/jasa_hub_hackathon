import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon/pages/main_page.dart';
import 'package:hackathon/widgets/custom_button.dart';
import 'package:hackathon/widgets/custom_gradient.dart';
import 'package:hackathon/widgets/custom_textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/usermodel.dart';
import '../widgets/widgets.dart';
import 'login_page.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.grey[400]!,
              ],
            ),
          ),
        ),
        elevation: 0,
        foregroundColor: fontColor,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: customGradient,
        ),
        child: _isLoading ? const Center(child: CircularProgressIndicator(color: fontColor)) : Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Sign up', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: fontColor)),
                ),
                const SizedBox(height: 10),
                CustomTextField(hint: 'Full name', icon: const Icon(Icons.person, color: iconColor), controller: nameController),
                const SizedBox(height: 20),
                CustomTextField(hint: 'abc@email.com', icon: const Icon(Icons.mail, color: iconColor), controller: emailController),
                const SizedBox(height: 20),
                CustomTextField(hint: 'Your password', icon: const Icon(Icons.lock, color: iconColor), controller: passwordController, obscureText: true),
                const SizedBox(height: 20),
                CustomTextField(hint: 'Confirm your password', icon: const Icon(Icons.lock, color: iconColor), controller: confirmPasswordController, obscureText: true),
                const SizedBox(height: 30),
                CustomButton(label: 'SIGN UP', onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  signUp(emailController.text, passwordController.text);
                }),
                const SizedBox(height: 30),
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 20,
                      color: fontColor,
                    ),
                    children: [
                      const TextSpan(
                          text: "Have an account? "
                      ),
                      TextSpan(
                        text: 'Sign in',
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                            nextScreenReplace(context, const LoginPage());
                          },
                        style: const TextStyle(
                          color: fontColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void signUp(String email, String password) async {
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty && nameController.text.isNotEmpty && passwordController.text == confirmPasswordController.text && passwordController.text.length > 5){
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirebase()})
            .catchError((e){
          Fluttertoast.showToast(msg: e!.message);
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', 'useremail@gmail.com');
      } on FirebaseAuthException catch (error){
        Fluttertoast.showToast(msg: error.message!);
      }

      Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(builder: (context) => MainPage()),
              (route) => false);
    } else{
      Fluttertoast.showToast(msg: 'Wrong format!');
    }

    setState(() {
      _isLoading = false;
    });
  }

  postDetailsToFirebase() async{
    FirebaseFirestore firebaseFirestore = await FirebaseFirestore.instance;
    User? user = await FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();


    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.fullName = nameController.text;
    userModel.status = 'user';
    userModel.favourite = [];


    await firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .set(userModel.toMap());
  }
}
