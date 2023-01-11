import 'package:flutter/material.dart';
import 'package:project/AdminPages/Dashborad.dart';
import 'package:project/AdminPages/MangePage/Mangeoptions.dart';
import 'package:project/Pages/FoodsClasstify.dart';
import 'package:project/Pages/PaymentPage.dart';
import 'package:project/Pages/TablePage.dart';
import 'package:project/Pages/ViewcartPage.dart';
import 'package:project/Pages/Viewmap.dart';
import 'package:project/Pages/introductionPage.dart';
import 'AdminPages/MangePage/Mangecategory.dart';
import 'AdminPages/MangePage/Mangefood.dart';
import 'AdminPages/MangePage/Mangeorders.dart';
import 'AdminPages/MangePage/Mangepayment.dart';
import 'AdminPages/MangePage/Mangeuser.dart';
import 'Pages/ChoicePage.dart';
import 'Pages/ConfrimOrderPage.dart';
import 'Pages/FoodDetailPage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/MenuPage.dart';
import 'Pages/RegisterPage.dart';
import 'Pages/completePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var _route = {
      '/login': (context) => LoginPage(),
      '/foodsclasstify': (context) => FoodsClasstify(),
      '/FoodDetailPage': (context) => FoodDetailPage(),
      '/register': (context) => RegisterPage(),
      '/table': (context) => TablePage(),
      '/menu': (context) => MenuPage(),
      '/': (context) => ChoicePage(),
      '/cart': (context) => ViewCartPage(),
      '/ConfirmOrder': (context) => ConfrimOrderPage(),
      '/ViewMap': (context) => ViewMapPage(),
      '/mangeuser': (context) => MangeUser(),
      '/mangefood': (context) => MangeFoods(),
      '/mangecategory': (context) => MangeCategory(),
      '/mangeoptions': (context) => MangeOptions(),
      '/mangeorders': (context) => MangeOrders(),
      '/mangepayment': (context) => MangePayments(),
      '/payment': (context) => PaymentPage(),
      '/complete': (context) => CompletePage(),
      '/admin': (context) => Dashborad(),
    };
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: _route,
    );
  }
}
