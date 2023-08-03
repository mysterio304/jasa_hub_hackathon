import 'package:flutter/material.dart';
import 'package:hackathon/widgets/widgets.dart';

class FaqDialog extends StatelessWidget {
  const FaqDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(228, 223, 223, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(height: 5),
            Text('About app', style: TextStyle(color: fontColor, fontWeight: FontWeight.w600, fontSize: 18)),
            SizedBox(height: 20),
            Text("The mobile app is a comprehensive platform for students and individuals. It allows users to explore universities, check their details, and add them to a favorites list. Additionally, users can manage their events and to-do tasks. The app provides examples of recommendation letters and motivation letters to support academic and career goals. It aims to simplify the university search process and enhance productivity for users.", style: TextStyle(color: fontColor, fontSize: 18)),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
