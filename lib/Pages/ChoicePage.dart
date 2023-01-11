// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ChoicePage extends StatelessWidget {
  const ChoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0c0f14),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        getCard('สั่งอาหารในร้าน', 'images/in.png', context, '/table'),
        SizedBox(height: 100),
        getCard('สั่งอาหารเดลิเวอรี่', 'images/de.png', context, '/login'),
      ])),
    );
  }

  Widget getCard(
          String name, String image, BuildContext context, String path) =>
      Container(
          child: Stack(children: [
        Container(
            padding: const EdgeInsets.all(12),
            width: 270,
            height: 150,
            decoration: BoxDecoration(
                color: Color(0xffF5F0E6),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Container(
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 26,
                    fontFamily: 'Kanit',
                    fontWeight: FontWeight.bold),
              ),
              alignment: Alignment.center,
            )),
        Positioned(
          top: -80,
          left: 65,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(180)),
              color: Color(0xffF5F0E6),
            ),
            width: 140,
            height: 140,
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
            top: 50,
            right: -25,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Color(0xffd17842),
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                iconSize: 30,
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, path);
                },
              ),
            ))
      ]));
}
