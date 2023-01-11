import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../constants/api.dart';
import '../services/OrderService.dart';

class ConfrimOrderPage extends StatefulWidget {
  const ConfrimOrderPage({Key? key}) : super(key: key);

  @override
  State<ConfrimOrderPage> createState() => _ConfrimOrderPageState();
}

class _ConfrimOrderPageState extends State<ConfrimOrderPage> {
  List orders = [];
  Position? userLocation;
  double? lag, lng;
  List<Placemark>? pm;
  var addresses = "";
  @override
  void initState() {
    _getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    orders = ModalRoute.of(context)!.settings.arguments as List;
    return Scaffold(
        backgroundColor: Color(0xff0c0f14),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xff0c0f14),
          elevation: 0,
        ),
        body: Container(
            child: Column(children: [
          Container(
            child: Text(
              'ชำระเงิน',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
              itemCount: orders[0].length,
              itemBuilder: (BuildContext context, int index) {
                return CardProduct(index);
              }),
          Container(
            child: Column(children: [Text('ที่อยู่'), Text(pm![0].toString())]),
          ),
          Container(
              child: Column(
            children: [
              Text(
                'รายละเอียดการชำระเงิน',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _decoration('ค่าส่ง', 'ฟรี'),
                      SizedBox(
                        height: 20,
                      ),
                      _decoration('ค่าอาหาร', orders[0]),
                      SizedBox(
                        height: 20,
                      ),
                      _decoration('ทั้งหมด', orders[0]),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('วิธีการชำะระเงิน',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Icon(Icons.money_sharp,
                              color: Colors.white, size: 30),
                          SizedBox(
                            width: 10,
                          ),
                          Text('โอนผ่านธนาคาร',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    ]),
              )
            ],
          )),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                backgroundColor: Color(0xffd17842),
              ),
              onPressed: () async {
                AnimatedButton(
                  text: 'Info Dialog fixed width and square buttons',
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                      width: 280,
                      buttonsBorderRadius: const BorderRadius.all(
                        Radius.circular(2),
                      ),
                      dismissOnTouchOutside: true,
                      dismissOnBackKeyPress: false,
                      onDissmissCallback: (type) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Dismissed by $type'),
                          ),
                        );
                      },
                      headerAnimationLoop: false,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'INFO',
                      desc: 'This Dialog can be dismissed touching outside',
                      showCloseIcon: true,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () async {
                        OrderService()
                            .SendOrder(orders[0], orders[1])
                            .then((value) => {
                                  if (value[0] == API.statucode)
                                    {
                                      Navigator.pushNamed(context, '/payment',
                                          arguments: [orders[0], orders[1]])
                                    }
                                });
                      },
                    ).show();
                  },
                );
              },
              child: Text("ยืนยันการชำระเงิน",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          )
        ])));
  }

  Widget _decoration(String text, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '$price บาท',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    setState(() async {
      pm = await placemarkFromCoordinates(
          userLocation!.latitude, userLocation!.longitude);
    });
  }

  Widget CardProduct(int index) {
    List options = json.decode(orders[0][index]['options']);
    return Container(
        width: 400,
        decoration: BoxDecoration(
          color: Color(0xff17191f),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Image.network(
                '${API.BASE_URL} ${orders[0][index]['image']}',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 10),
            Container(
                margin: const EdgeInsets.all(8),
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${orders[0][index]['name']}',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Kanit',
                          color: Color(0xffaeaeae),
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\฿\t',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Kanit',
                                  color: Color(0xffd17842),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${orders[0][index]['price']}',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Kanit',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: Text('${orders[0][index]['quantity']} ชิ้น',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        )
                      ],
                    ),
                  ],
                )),
          ],
        ));
  }
}
