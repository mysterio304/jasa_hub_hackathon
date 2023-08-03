import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackathon/pages/main_page.dart';
import 'package:hackathon/pages/register_page.dart';
import 'package:hackathon/widgets/custom_button.dart';
import 'package:hackathon/widgets/custom_gradient.dart';
import 'package:hackathon/widgets/custom_logo.dart';
import 'package:hackathon/widgets/custom_textfield.dart';
import 'package:hackathon/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: customGradient,
        ),
        child: _isLoading ? const Center(child: CircularProgressIndicator(color: fontColor)) : Padding(
          padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                const CustomLogo(),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Sign in', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: fontColor)),
                ),
                const SizedBox(height: 10),
                CustomTextField(hint: 'abc@email.com', icon: const Icon(Icons.mail, color: iconColor), controller: emailController),
                const SizedBox(height: 20),
                CustomTextField(hint: 'Your password', icon: const Icon(Icons.lock, color: iconColor), controller: passwordController, obscureText: true),
                const SizedBox(height: 30),
                CustomButton(label: 'SIGN IN', onPressed: () async{
                  setState(() {
                    _isLoading = true;
                  });
                  signIn(emailController.text, passwordController.text);
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
                        text: "Don't have an account? "
                      ),
                      TextSpan(
                        text: 'Sign up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = (){
                            nextScreen(context, const RegisterPage());
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

  void signIn(String email, String password) async{
    print(emailController.text);
    print(passwordController.text);
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      try{
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
          Fluttertoast.showToast(msg: 'Вы успешно вошли!'),
          nextScreenReplace(context, MainPage()),
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', 'useremail@gmail.com');
      } on FirebaseAuthException catch (e){
        Fluttertoast.showToast(msg: 'Неверные данные!');
      }
    } else{
      Fluttertoast.showToast(msg: 'Поля не заполнены!');
    }

    setState(() {
      _isLoading = false;
    });
  }
}