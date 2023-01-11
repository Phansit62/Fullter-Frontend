// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
      pages: [
        PageViewModel(
          title: "ค้นหารายการอาหาร",
          body: "",
          image: Center(
            child: Image.asset(
              "images/intro1.png",
              height: double.infinity,
            ),
          ),
          decoration: const PageDecoration(
              fullScreen: true,
              bodyFlex: 5,
              titleTextStyle: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
        PageViewModel(
          title: "สั่งอาหาร",
          body: "",
          image: Center(
            child: Image.asset(
              "images/intro2.png",
              height: double.infinity,
            ),
          ),
          decoration: const PageDecoration(
              fullScreen: true,
              bodyFlex: 5,
              titleTextStyle: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
        PageViewModel(
          title: "รอรับอาหารได้เลย",
          body: "",
          image: Center(
            child: Image.asset(
              "images/intro3.png",
              height: double.infinity,
            ),
          ),
          decoration: const PageDecoration(
              fullScreen: true,
              bodyFlex: 5,
              titleTextStyle: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
      ],
      globalBackgroundColor: Color(0xff0c0f14),
      next: Icon(Icons.arrow_forward, color: Colors.white),
      done: Text('เสร็จสิ้น',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      onDone: () => Navigator.of(context).pushReplacementNamed('/choice'),
    ));
  }
}
