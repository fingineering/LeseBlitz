import 'package:flutter/material.dart';

class MainRowLayout extends StatelessWidget {
  // constructor
  const MainRowLayout({super.key, this.word = 'Das ist ein Text'});
  final String word;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Icon(Icons.arrow_back_ios_new),
      Expanded(
          child: Text(
        word,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      )),
      Icon(Icons.arrow_forward_ios)
    ]);
  }
}
