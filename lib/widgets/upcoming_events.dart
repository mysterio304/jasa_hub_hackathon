import 'package:flutter/material.dart';

class UpcomingEvents extends StatefulWidget {
  const UpcomingEvents({Key? key, required this.widgets}) : super(key: key);

  final List<Widget>? widgets;

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {

  late PageController controller;
  int currentpage = 0;

  @override
  initState() {
    super.initState();
    controller = PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: 0.5,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: PageView.builder(
          onPageChanged: (value){
            setState(() {
              currentpage = value;
            });
          },
          controller: controller,
          itemBuilder: (context, index) => builder(index),
        ),
      ),
    );
  }

  builder(int index){
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = controller.page! - index;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * 300,
            width: Curves.easeOut.transform(value) * 250,
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        color: const Color.fromRGBO(228, 223, 223, 1),
        child: widget,
      ),
    );
  }


}
