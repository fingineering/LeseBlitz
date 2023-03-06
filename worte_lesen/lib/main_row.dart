import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

class MainRowLayout extends StatefulWidget {
  const MainRowLayout(
      {super.key, this.word = "Wort", this.mainFontSize = 160.0});

  final String word;
  final double mainFontSize;

  @override
  State<MainRowLayout> createState() => _MainRowLayoutState();
}

class _MainRowLayoutState extends State<MainRowLayout> {
  String word = "Willkommen bei LeseBlitz";
  bool visible = true;
  final duration = const Duration(milliseconds: 700);
  int _counter = -1;
  List<String> worte = ['Hello', 'Welt', 'Foo', 'Bar', 'Baz'];

  void changeWord(String direction) {
    setState(() {
      if (direction == 'ff') {
        _counter++;
        word = worte[_counter];
      } else if (_counter > 0) {
        _counter--;
        word = worte[_counter];
      } else {}
      if (visible && _counter >= 0) {
        visible = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            iconSize: widget.mainFontSize,
            onPressed: () {
              changeWord('rr');
            }),
      ),
      Expanded(
          child: InkWell(
              onTap: () {
                if (visible && _counter >= 0) {
                  setState(() {
                    visible = false;
                  });
                } else if (_counter >= 0) {
                  setState(() {
                    visible = true;
                  });
                  Timer timer = Timer(Duration(milliseconds: 700), () {
                    setState(() {
                      visible = false;
                    });
                    changeWord('ff');
                  });
                }
              },
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
                          fontSize: widget.mainFontSize,
                        ),
                      ))))),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            iconSize: widget.mainFontSize,
            onPressed: () {
              changeWord('ff');
            },
          ))
    ]);
  }
}

typedef WordChangeCallback = void Function(String direction);
