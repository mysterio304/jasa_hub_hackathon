import 'package:flutter/material.dart';
import 'package:hackathon/widgets/widgets.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset('assets/profhub_logo.png', width: 120, height: 120),
          Text.rich(
            TextSpan(
              style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.w600, fontSize: 32),
              children: const [
                TextSpan(
                  text: 'Prof',
                ),
                TextSpan(
                  text: 'Hub',
                  style: TextStyle(color: fontColor, fontWeight: FontWeight.w600, fontSize: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
