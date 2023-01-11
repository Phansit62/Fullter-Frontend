// ignore_for_file: file_names

import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/Models/CustomersModel.dart';
import 'package:project/constants/api.dart';
import 'package:project/services/CusService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var user = Customers();
  var isLogin = false;

  @override
  void initState() {
    super.initState();
    _chkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0c0f14),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Center(
              child: Form(
                  key: _formKey,
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // Container(
                      //   child: Image.asset(''),
                      // ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        initialValue: user.username,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff141921),
                          hintStyle: TextStyle(color: Color(0xff52555a)),
                          border: OutlineInputBorder(),
                          label: Text("ชื่อผู้ใช้",
                              style: TextStyle(
                                  color: Color(0xff52555a),
                                  fontSize: 20,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold)),
                        ),
                        onSaved: (String? value) {
                          user.username = value!;
                        },
                        validator: (String? value) {
                          return (value!.isEmpty)
                              ? 'กรุณากรอกชื่อผู้ใช้งาน'
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        initialValue: user.password,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xff141921),
                          hintStyle: TextStyle(color: Color(0xff52555a)),
                          border: OutlineInputBorder(),
                          label: Text("รหัสผ่าน",
                              style: TextStyle(
                                  color: Color(0xff52555a),
                                  fontSize: 20,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold)),
                        ),
                        onSaved: (String? value) {
                          user.password = value!;
                        },
                        validator: (String? value) {
                          return (value!.isEmpty) ? 'กรุณากรอกรหัสผ่าน' : null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            backgroundColor: Color(0xffd17842),
                          ),
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;
                            _formKey.currentState!.save();
                            FocusScope.of(context).requestFocus(FocusNode());
                            CusService()
                                .login(user)
                                .then((value) => _goMenu(value))
                                .onError((error, stackTrace) =>
                                    print((error as DioError).message));
                            ;
                          },
                          child: Text("เข้าสู่ระบบ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            backgroundColor: Colors.transparent,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text("สมัครสมาชิก",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold)),
                        ),
                      )
                    ],
                  )))),
    );
  }

  _goMenu(List<String> value) async {
    if (value[0] == API.statucode) {
      CoolAlert.show(
        context: context,
        width: 150,
        type: CoolAlertType.success,
        text: "เข้าสุ่ระบบสำเร็จ",
      );
      var prefs = await SharedPreferences.getInstance();
      prefs.setBool(API.ISLOGIN, true);
      prefs.setString(API.USERID, value[1]);
      Navigator.pushNamed(context, '/menu');
    } else if (value[0] == '2') {
      CoolAlert.show(
        context: context,
        width: 150,
        type: CoolAlertType.success,
        text: "เข้าสุ่ระบบสำเร็จ",
      );
      var prefs = await SharedPreferences.getInstance();
      prefs.setBool(API.ADMIN, true);
      Navigator.pushNamed(context, '/admin');
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "เข้าสุ่ระบบไม่สำเร็จ กรุณาลองใหม่อีกครั้ง",
      );
    }
  }

  _chkLogin() async {
    var prefs = await SharedPreferences.getInstance();
    var chk = prefs.get(API.ISLOGIN);
    setState(() {
      isLogin = chk as bool;
    });
  }
}
