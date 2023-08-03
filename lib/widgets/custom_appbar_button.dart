import 'package:flutter/material.dart';
import 'package:hackathon/widgets/widgets.dart';

class CustomAppBarButton extends StatelessWidget {
  const CustomAppBarButton({Key? key, required this.width, this.onPressed, required this.title, required this.icon}) : super(key: key);

  final double width;
  final String title;
  final Icon icon;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
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
              child: icon,
            ),
            const SizedBox(width: 2),
            Text(title, style: const TextStyle(color: fontColor, fontSize: 12)),
          ],
        ),
        onPressed: () {
          onPressed;
        },
      ),
    );
  }
}
