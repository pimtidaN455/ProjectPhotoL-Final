import 'package:flutter/material.dart';

class Howto1 {
  @override
  // ignore: override_on_non_overriding_member
  Widget(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'photo learn',
          style: TextStyle(
            fontSize: 60,
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            //fontStyle: FontStyle.normal,
            fontFamily: 'Rajdhani',
          ),
        ),
      ],
    )));
  }
}
