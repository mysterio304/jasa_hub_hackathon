import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.label, required this.onPressed, this.height}) : super(key: key);

  final String label;
  final Function onPressed;
  final String type = 'basic';
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: height ?? MediaQuery.of(context).size.width * 0.15,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(27, 38, 59, 1),
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(27, 38, 59, 1),
              offset: Offset(0, 3),
              blurRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
    );
  }
}
