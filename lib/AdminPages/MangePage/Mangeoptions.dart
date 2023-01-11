// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:project/AdminPages/optionspage/addOption.dart';
import 'package:project/AdminPages/optionspage/detailOption.dart';
import 'package:project/Models/OptionModel.dart' as optionModel;
import 'package:project/services/OptionsService.dart';

class MangeOptions extends StatefulWidget {
  const MangeOptions({Key? key}) : super(key: key);

  @override
  State<MangeOptions> createState() => _MangeOptionsState();
}

class _MangeOptionsState extends State<MangeOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffd17842),
          child: Icon(Icons.add),
          onPressed: () => showModalBottomSheet(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            backgroundColor: Color(0xff0c0f14),
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Container(
                  height: 620,
                  child: AddOption(),
                ),
              );
            },
          ).then((value) {
            setState(() {});
          }),
        ),
        backgroundColor: Color(0x1A1F24),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(26, 0, 16, 12),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'ข้อมูลตัวเลือกอาหาร',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: FutureBuilder<List<optionModel.Options>>(
                  future: OptionsService().getOptions(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data as List<optionModel.Options>;
                      return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: _gridView(data));
                    }
                    if (snapshot.hasError) {
                      var err = (snapshot.error).toString();
                      return Text(err, style: TextStyle(color: Colors.white));
                    }
                    return Center(
                      child: Lottie.asset('assets/99276-loading-utensils.json'),
                    );
                  }),
            ),
          ]),
        ));
  }

  Widget _gridView(List<optionModel.Options> data) {
    return ListView.builder(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: _Card(data[index]),
          );
        });
  }

  Widget _Card(optionModel.Options data) {
    return Slidable(
      key: Key(data.optionsId.toString()),
      endActionPane: ActionPane(
        motion: BehindMotion(),
        dismissible: DismissiblePane(
          onDismissed: () async =>
              OptionsService().deleteOption(data.optionsId as int),
        ),
        children: [],
      ),
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          backgroundColor: Color(0xff0c0f14),
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: 670,
                child: DetailOption(
                  options: data,
                ),
              ),
            );
          },
        ).then((value) => setState(() {})),
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Color(0x2E000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xFFDBE2E7),
              width: 2,
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.category,
                                color: Color(0xFF4B39EF),
                                size: 26,
                              ),
                            ),
                          ),
                          Text(
                            '${data.titlename}',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF090F13),
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 4, 4),
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: Color(0xFF57636C),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
