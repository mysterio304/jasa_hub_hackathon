import 'package:flutter/material.dart';
import 'package:hackathon/widgets/widgets.dart';

class UpcomingEventCard extends StatelessWidget {
  const UpcomingEventCard({
    Key? key,
    required this.day,
    required this.month,
    required this.title,
    required this.cost,
    required this.level,
    required this.type,
    required this.isOpen,
    this.url
  }) : super(key: key);

  final String day;
  final String month;
  final String title;
  final int cost;
  final String level;
  final String type;
  final bool isOpen;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      padding: const EdgeInsets.all(8),
      height: 180,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(228, 223, 223, 1),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.width * 0.4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: url == '' ? const Center(child: Text('No photo', style: TextStyle(fontSize: 18, color: fontColor))) : Image.network(url!, fit: BoxFit.fill),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${day}\n',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.pinkAccent),
                          ),
                          TextSpan(
                            text: getNameOfMonth(month),
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.pinkAccent),
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black)),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      const Icon(Icons.attach_money_outlined),
                      Text(cost == 0 ? 'Free' : 'Paid', style: const TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    children: [
                      Icon(isOpen ? Icons.lock_open_outlined : Icons.lock_outline),
                      Text(isOpen ? 'Open' : 'Close', style: const TextStyle(fontSize: 16, color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(type, style: const TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(level, style: const TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getNameOfMonth(month){
    List months = ['December', 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November'];
    return months[int.parse(month)];
  }

}
