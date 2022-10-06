// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/manage_album_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/setting_album_client.dart';

class rename_album extends StatefulWidget {
  // const rename_album({Key? key}) : super(key: key);
  var name;
  rename_album({required this.name});
  @override
  _rename_albumState createState() => _rename_albumState(name: this.name);
}

class _rename_albumState extends State<rename_album> {
  //String pagereset;
  //var user;
  var name;
  _rename_albumState({required this.name});

  late double screen;
  TextEditingController rename = TextEditingController();
  //bool _isObscure = true;
  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: MyStyle().blackColor,
            ),
            onPressed: () async {
              DBHelper db = new DBHelper();
              var dataalbum = await db.getData_Album(this.name);
              print("*******////*****");
              print(dataalbum);

              print("*******////*****");
              print(dataalbum[0]['IDENTITYALBUM']);
              var page;
              var page2;

              var description = "";
              var keyword = "";
              if (dataalbum[0]['DESCRIPTIONALBUM'].length != 0) {
                description = dataalbum[0]['DESCRIPTIONALBUM'];
              }
              if (dataalbum[0]['KEYWORDALBUM'].length != 0) {
                //keyword = dataalbum[0]['KEYWORDALBUM'];
                for (int i = 0; i < dataalbum[0]['KEYWORDALBUM'].length; ++i) {
                  if (dataalbum[0]['KEYWORDALBUM'][i] == "/" &&
                      i < dataalbum[0]['KEYWORDALBUM'].length - 1) {
                    keyword += " , ";
                  } else if (dataalbum[0]['KEYWORDALBUM'][i] != "/") {
                    keyword += dataalbum[0]['KEYWORDALBUM'][i];
                  }
                }
              }
              print(description);
              print(keyword);
              page = setting_Album_Client(
                  title: this.name, description: description, keyword: keyword);

              /*page2 = ShowImage( name : name,
   listimageshow : listimageshow , 
 statusAlbum: statusAlbum);*/

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => page));
            },
          ),
          title: Text(
            "Rename Album",
            style: TextStyle(
              fontSize: 30,
              color: MyStyle().blackColor,
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.normal,
              fontFamily: 'Rajdhani',
            ),
          ),
          backgroundColor: MyStyle().whiteColor,
        ),
        body: Container(
          child: Container(
            alignment: Alignment.topLeft,

            //mainAxisSize: MainAxisSize.max,
            child: SingleChildScrollView(
              // alignment: Alignment.topLeft,
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsetsDirectional.fromSTEB(45, 10, 0, 0),
                  child: Text(
                    'Old Name Album : ' +
                        this.name +
                        "\n" +
                        "New name Album : ",
                    style: TextStyle(
                      fontSize: 20,
                      color: MyStyle().blackColor,
                      fontWeight: FontWeight.bold,
                      //fontStyle: FontStyle.normal,
                      fontFamily: 'Rajdhani',
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    key: _fromKey,
                    child: SingleChildScrollView(
                      // padding: EdgeInsets.all(10),
                      child: Column(children: [
                        Namere(),
                        NextToRePassWord(),
                      ]),
                    )),
              ]),
            ),
          ),
        ));
  }

  Container Namere() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.8,
      child: TextFormField(
        controller: rename,
        decoration: InputDecoration(
            hintText: name,
            prefixIcon: Icon(Icons.people_alt),
            suffixIcon: IconButton(
              onPressed: () {
                rename.clear();
              },
              icon: const Icon(Icons.clear),
            ),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        validator: (value) {
          final emailRegex = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
          if (value!.isEmpty) {
            return "Please enter Email for repassword";
          }
          if (emailRegex.hasMatch(value)) {
            return null;
          } else
            return "Please enter a valid email.";
        },
      ),
    );
  }

  Container NextToRePassWord() {
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: ElevatedButton(
        /* onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(
                'Application ได้ทำการส่ง Email เพื่อให้ผู้ใข้ทำการเปลี่ยนรหัสผ่านดรียบร้อย'),
          ),
        ),*/
        onPressed: () async {
          /*  var nameedit = [];
          nameedit.add(name);
          nameedit.add(rename.text);*/
          //  print(this.title);
          var itemEdit = {
            "namealbum": rename.text,
            "nameoldalbum": this.name,
            "keyword": "",
            "description": "",
            "status": "update"
          };
          await AlertDialogs_manage_album.yesCancelDialog(
              context,
              'Update name album',
              'are you sure?',
              this.name,
              "update",
              itemEdit,
              "");
          print(rename.text);
          rename.text;
        },
        child: Text(
          'Confirm',
          style: TextStyle(
            fontSize: 20,
            color: MyStyle().whiteColor,
            fontWeight: FontWeight.bold,
            //fontStyle: FontStyle.normal,
            fontFamily: 'Rajdhani',
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: MyStyle().blackColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
