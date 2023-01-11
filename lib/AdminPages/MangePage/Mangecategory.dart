// ignore_for_file: file_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:project/AdminPages/category/addCategory.dart';
import 'package:project/AdminPages/category/detailCategory.dart';
import 'package:project/Models/CategoryModel.dart';
import 'package:project/services/CategoryService.dart';

class MangeCategory extends StatefulWidget {
  const MangeCategory({Key? key}) : super(key: key);

  @override
  State<MangeCategory> createState() => _MangeCategoryState();
}

class _MangeCategoryState extends State<MangeCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffd17842),
          child: Icon(Icons.add),
          onPressed: () => showModalBottomSheet(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
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
                  child: AddCategory(),
                ),
              );
            },
          ).then((value) => {setState(() {})}),
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
                    'ข้อมูลประเภทอาหาร',
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
              height: 550,
              child: FutureBuilder<List<CategoryFoods>>(
                  future: CategoryService().getCategory(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data as List<CategoryFoods>;
                      return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: _gridView(data));
                    }
                    if (snapshot.hasError) {
                      var err = (snapshot.error as DioError).message;
                      return Text(err);
                    }
                    return Center(
                      child: Lottie.asset('assets/99276-loading-utensils.json'),
                    );
                  }),
            ),
          ]),
        ));
  }

  Widget _gridView(List<CategoryFoods> data) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: _CardCategoryItem(data[index]),
          );
        });
  }

  Widget _CardCategoryItem(CategoryFoods data) {
    return Slidable(
      key: Key(data.categoryFoodId.toString()),
      endActionPane: ActionPane(
        motion: BehindMotion(),
        dismissible: DismissiblePane(
          onDismissed: () async => await CategoryService()
              .deleteCategory(data.categoryFoodId as int)
              .then((value) => {setState(() {})}),
        ),
        children: [],
      ),
      child: GestureDetector(
        onTap: () => showModalBottomSheet(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
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
                height: 620,
                child: DetailCategory(categoryFoods: data),
              ),
            );
          },
        ).then((value) => {setState(() {})}),
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: Color(0x32171717),
                offset: Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/bar.png',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${data.typeFood}',
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            'รายการ ${data.foods!.length}',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF57636C),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
        ),
      ),
    );
  }
}
