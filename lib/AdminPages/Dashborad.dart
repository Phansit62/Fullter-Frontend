// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:project/AdminPages/mangedata.dart';
import 'package:project/constants/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashborad extends StatefulWidget {
  const Dashborad({Key? key}) : super(key: key);

  @override
  State<Dashborad> createState() => _DashboradState();
}

class _DashboradState extends State<Dashborad> {
  late List<dynamic> screens = [
    MangedataPage(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x1A1F24),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        selectedFontSize: 16,
        unselectedFontSize: 13,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'จัดการข้อมูล',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'รายงาน',
          ),
        ],
      ),
    );
  }

  void _logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(API.ADMIN);
    Navigator.pushNamed(context, '/');
  }
}
