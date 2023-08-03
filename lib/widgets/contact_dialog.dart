import 'package:flutter/material.dart';
import 'package:hackathon/widgets/widgets.dart';

class ContactDialog extends StatelessWidget {
  const ContactDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(228, 223, 223, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Our contacts', style: TextStyle(color: fontColor, fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),
            Row(
              children: const [
                Icon(Icons.share, color: fontColor),
                SizedBox(width: 5),
                Text('Instagram: PROF_HUBB', style: TextStyle(color: fontColor, fontSize: 18, fontWeight: FontWeight.w600)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
