// ignore_for_file: file_names
import 'package:advance_notification/advance_notification.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project/Models/CategoryModel.dart';
import 'package:project/constants/api.dart';
import 'package:project/services/CategoryService.dart';

class DetailCategory extends StatefulWidget {
  DetailCategory({required this.categoryFoods});
  CategoryFoods categoryFoods = CategoryFoods();
  @override
  State<DetailCategory> createState() => _DetailCategoryState();
}

class _DetailCategoryState extends State<DetailCategory> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool edit = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Divider(
            thickness: 3,
            indent: 150,
            endIndent: 150,
            color: Color(0xFF465056),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(26, 0, 16, 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10, top: 10),
                  child: Text(
                    'รายละเอียดประเภทอาหาร',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10, top: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        edit = !edit;
                      });
                    },
                    child: Text(
                      'แก้ไข',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _form(),
        ],
      ),
    );
  }

  Widget _form() {
    return SizedBox(
      height: 220,
      width: MediaQuery.of(context).size.width,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: TextFormField(
                readOnly: edit,
                initialValue: widget.categoryFoods.typeFood,
                decoration: InputDecoration(
                  labelText: 'ชื่อประเภทอาหาร',
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
                onSaved: (String? value) {
                  widget.categoryFoods.typeFood = value!;
                },
                validator: (String? value) {
                  return (value!.isEmpty) ? 'กรุณากรอกข้อมูล' : null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  height: 50,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: edit
                      ? null
                      : ElevatedButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;
                            _formKey.currentState!.save();
                            FocusScope.of(context).requestFocus(FocusNode());
                            CategoryService()
                                .editCategory(widget.categoryFoods)
                                .then((value) => _Alet(value))
                                .onError((error, stackTrace) =>
                                    print((error as DioError).message));
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xffd17842),
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Kanit',
                                  fontWeight: FontWeight.bold)),
                          child: Text('บันทึก')),
                ),
                Container(
                  width: 160,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.black54,
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Kanit',
                              fontWeight: FontWeight.bold)),
                      child: Text(
                        'ยกเลิก',
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _Alet(String value) async {
    if (value == API.statucode) {
      Navigator.pop(context);
      return AdvanceSnackBar(
        message: "แก้ไขข้อมูลเรียบร้อย",
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 5),
      ).show(context);
    }
  }
}
