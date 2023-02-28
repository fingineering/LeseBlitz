import 'package:flutter/material.dart';

class MainRowLayout extends StatelessWidget {
  // constructor
  const MainRowLayout(
      {super.key,
      required this.changeWord,
      this.word = 'Das ist ein Text',
      this.mainFontSize = 160.0});
  final String word;
  final double mainFontSize;
  bool visible = false;

  final WordChangeCallback changeWord;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            iconSize: mainFontSize,
            onPressed: () {
              changeWord('rr');
            }),
      ),
      Expanded(
          child: Container(
              alignment: Alignment.center,
              child: Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: visible,
                  child: Text(
                    word,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: mainFontSize,
                    ),
                  )))),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            iconSize: mainFontSize,
            onPressed: () {
              changeWord('ff');
            },
          ))
    ]);
  }
}

typedef WordChangeCallback = void Function(String direction);
