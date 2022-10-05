import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/delete_img_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/manageimage_homt.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';

class SelectImageHomePage extends StatefulWidget {
  var imageListD;
  var title;
  var lenListC;
  var iconselect;
  var statusitem;
  SelectImageHomePage({
    required this.imageListD,
    required this.lenListC,
    required this.iconselect,
    required this.statusitem,
    required this.title,
  });

  @override
  _SelectImageDeviceState createState() => _SelectImageDeviceState(
        imageListD: this.imageListD,
        lenListC: this.lenListC,
        iconselect: this.iconselect,
        statusitem: this.statusitem,
        title: this.title,
      );
}

class _SelectImageDeviceState extends State<SelectImageHomePage> {
  var imageListD;
  var lenListC;
  var iconselect;
  var statusitem;
  var title;
//  var iconselect;
  _SelectImageDeviceState(
      {required this.imageListD,
      required this.lenListC,
      required this.iconselect,
      required this.statusitem,
      required this.title});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("หน้าเลือกแล้วจ้า");
    print(this.imageListD.length);
    print("OOOOOO-----OOOOOO");
    //print(this.imageListC.length);
    print(this.iconselect);
    print("ค่าาาาาา");

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Device",
            style: TextStyle(
              color: MyStyle().whiteColor,
            )),
        centerTitle: false,
        backgroundColor: MyStyle().blackColor,
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.assignment_turned_in_outlined,
              color: MyStyle().whiteColor,
            ),
            onPressed: () async {
              print("****/////******/////****");
              if (iconselect == "Delete") {
                await AlertDialogs_Delete_img.yesCancelDialog(
                    context, 'Delete', 'are you sure?', this.title, imageListD);
              } else if (iconselect == "Move") {
                //   await manage_img.move();
              }
              //  if (imageListC.length != 0) {}
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1,
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0),
        itemCount: this.imageListD.length,
        itemBuilder: (builder, index) {
          return InkWell(
              onTap: () {
                if (this.imageListD.length != 0) {
                  setState(() {
                    print(index);
                    this.imageListD[index].isSelected =
                        !this.imageListD[index].isSelected;
                  });
                }
                /*    if (this.imageListC.length != 0) {
                  setState(() {
                    this.imageListC[index].isSelected =
                        !this.imageListC[index].isSelected;
                  });
                }*/
              },
              child: Stack(
                children: [
                  if (this.imageListD.length != 0 &&
                      index <= (this.imageListD.length - this.lenListC) - 1 &&
                      this.statusitem == "Have 2")
                    _getImage(imageListD[index].imageURL),
                  if (this.imageListD.length != 0 &&
                      index <= (this.imageListD.length - this.lenListC) - 1 &&
                      this.statusitem == "Have 2")
                    Opacity(
                      opacity: this.imageListD[index].isSelected ? 1 : 0,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black38,
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: this.iconselect == 'move'
                                  ? Color.fromARGB(255, 255, 255, 255)
                                  : Color.fromARGB(255, 255, 0, 0),
                              child: Icon(
                                Icons.check,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  if (this.imageListD.length != 0 &&
                      index > (this.imageListD.length - this.lenListC) - 1 &&
                      this.statusitem == "Have 2")
                    _getImageC(imageListD[index].imageURL),
                  if (this.imageListD.length != 0 &&
                      index > (this.imageListD.length - this.lenListC) - 1 &&
                      this.statusitem == "Have 2")
                    Opacity(
                      opacity: this.imageListD[index].isSelected ? 1 : 0,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black38,
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: this.iconselect == 'move'
                                  ? Color.fromARGB(255, 192, 192, 192)
                                  : Color.fromARGB(255, 170, 22, 22),
                              child: Icon(
                                Icons.check,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  if (this.imageListD.length != 0 &&
                      this.statusitem == "Have 1 Cloud")
                    _getImageC(imageListD[index].imageURL),
                  if (this.imageListD.length != 0 &&
                      this.statusitem == "Have 1 Cloud")
                    Opacity(
                      opacity: this.imageListD[index].isSelected ? 1 : 0,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black38,
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: this.iconselect == 'move'
                                  ? Color.fromARGB(255, 255, 255, 255)
                                  : Color.fromARGB(255, 255, 0, 0),
                              child: Icon(
                                Icons.check,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  if (this.imageListD.length != 0 &&
                      this.statusitem == "Have 1 Device")
                    _getImage(imageListD[index].imageURL),
                  if (this.imageListD.length != 0 &&
                      this.statusitem == "Have 1 Device")
                    Opacity(
                      opacity: this.imageListD[index].isSelected ? 1 : 0,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black38,
                          ),
                          Center(
                            child: CircleAvatar(
                              backgroundColor: this.iconselect == 'move'
                                  ? Color.fromARGB(255, 255, 255, 255)
                                  : Color.fromARGB(255, 255, 0, 0),
                              child: Icon(
                                Icons.check,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ));
        },
      ),
    );
  }

  _getImage(url) => Ink.image(
        fit: BoxFit.cover,
        image: FileImage(File(url)),
      );
  _getImageC(url) => Image.network(
        url,
        height: 500,
        fit: BoxFit.fitHeight,
      );

  @override
  void dispose() {
    super.dispose();
  }
}
