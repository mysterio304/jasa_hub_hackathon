import 'package:flutter/material.dart';
import 'package:hackathon/widgets/widgets.dart';

class CareerCard extends StatelessWidget {
  const CareerCard({Key? key, required this.onPressed, required this.title, required this.subtitle}) : super(key: key);

  final Function onPressed;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Text(title, style: const TextStyle(fontSize: 24, color: fontColor, fontWeight: FontWeight.w500)),
            Text(subtitle, style: const TextStyle(color: fontColor)),
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
                  onPressed;
                },
                child: const Text('COPY LINK'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
