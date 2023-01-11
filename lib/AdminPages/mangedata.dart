import 'package:flutter/material.dart';
import 'package:project/services/CategoryService.dart';
import 'package:project/services/CusService.dart';
import 'package:project/services/FoodService.dart';

class MangedataPage extends StatefulWidget {
  const MangedataPage({Key? key}) : super(key: key);

  @override
  State<MangedataPage> createState() => _MangedataPageState();
}

class _MangedataPageState extends State<MangedataPage> {
  var _order = 0;
  var _user = 0;
  var _cate = 0;
  var _food = 0;
  var _payment = 0;

  @override
  void initState() {
    setState(() {
      CusService().getCustomers().then((value) => _user = value.length);
      FoodService().getFoods().then((value) => _food = value.length);
      CategoryService().getCategory().then((value) => _cate = value.length);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x1A1F24),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () => Navigator.pushNamed(context, '/'),
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.all(18),
                  child: Text('จัดการข้อมูลทั่วไป',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start)),
              Padding(
                  padding: EdgeInsets.all(12),
                  child: Center(
                    child: Wrap(
                      spacing: 20.0,
                      runSpacing: 20.0,
                      children: [
                        _CardView(
                            context, 'images/man.png', 'ผู้ใช้', '/mangeuser'),
                        _CardView(context, 'images/hot-pot.png', 'อาหาร',
                            '/mangefood'),
                        _CardView(context, 'images/payment.png', 'ชำระเงิน',
                            '/mangepayment'),
                        _CardView(context, 'images/order.png', 'คำสั่งซื้อ',
                            '/mangeorders'),
                        _CardView(context, 'images/cate.png', 'ประเภท',
                            '/mangecategory'),
                        _CardView(context, 'images/answer.png', 'ตัวเลือก',
                            '/mangeoptions'),
                      ],
                    ),
                  ))
            ],
          ),
        )));
  }

  Widget _CardView(
      BuildContext context, String image, String title, String map) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, map);
        },
        child: SizedBox(
            width: 160,
            height: 160,
            child: Card(
              color: Color.fromARGB(255, 21, 21, 21),
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(image, width: 74),
                    SizedBox(
                      height: 5,
                    ),
                    Text(title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              )),
            )));
  }
}
