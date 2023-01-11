// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:project/Models/PaymentModel.dart';
import 'package:project/constants/api.dart';

class DetaillPayment extends StatefulWidget {
  DetaillPayment({Key? key, required this.payment}) : super(key: key);
  Payments payment = Payments();
  @override
  State<DetaillPayment> createState() => _DetaillPaymentState();
}

class _DetaillPaymentState extends State<DetaillPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0c0f14),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'หมายเลขใบเสร็จ: #${widget.payment.paymentId}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'วันที่ชำระเงิน: ${widget.payment.dateIn}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'สถานะใบเสร็จ',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${widget.payment.status == false ? 'ยังไม่ได้ชำระเงิน' : 'ชำระเงินแล้ว'}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ]),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xff17191f),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
            ),
            Container(
              width: 350,
              margin: EdgeInsets.all(16),
              child: _ShowImage(),
            ),
          ],
        ),
      )),
    );
  }

  Widget _ShowImage() {
    return Container(
        child: Container(
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          '${API.BASE_URL}${widget.payment.image}',
          fit: BoxFit.cover,
          width: 100,
        ),
      ),
    ));
  }
}
