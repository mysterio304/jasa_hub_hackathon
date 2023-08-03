import 'package:flutter/material.dart';

const fontColor = Color.fromRGBO(10, 22, 34, 1);
const iconColor = Color.fromRGBO(128, 122, 122, 1);
const bottomBarIconColor = Color.fromRGBO(52, 72, 95, 1);

const authInputDecoration = InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.never,
  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1),
  ),
);

const addStudentInputDecoration = InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.never,
  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 5),
  )
);


const authInputStyle = TextStyle(
  color: Colors.black,
  fontSize: 14,
);

const authLabelStyle = TextStyle(
  color: Colors.grey,
  fontSize: 14,
  fontWeight: FontWeight.w500,
);


void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

const textInputDecoration = InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.never,
  labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1),
  ),
  errorBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1),
  ),
);

const textInputForm = TextStyle(
  color: Colors.white,
  fontSize: 14,
);

const itemInputDecoration = InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.never,
  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
  filled: true,
  fillColor: Colors.white,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 0, color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 0, color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 0, color: Colors.red),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

const nameSearchDecoration = InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.never,
  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
  filled: true,
  fillColor: Colors.white,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 0, color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 0, color: Colors.white),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 0, color: Colors.red),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

const labelInputDecoration = TextStyle(
  fontWeight: FontWeight.w700,
  color: Colors.grey,
  fontSize: 14,
);

const drawerTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: Colors.white,
  // color: Color.fromRGBO(95, 93, 104, 1),
);
