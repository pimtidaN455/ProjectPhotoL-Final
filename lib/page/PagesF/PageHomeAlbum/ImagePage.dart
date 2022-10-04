import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
//import 'package:project_photo_learn/page/PagesF/PageClound/FileCloudPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImageSliderPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/selectImage_Home.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/setting_album_client.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/setting_album_server.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

import '../../Backend/User_data.dart';

// ignore: must_be_immutable
class ShowImage extends StatefulWidget {
  var name;
  var listimageshow;
  var statusAlbum;
  ShowImage({this.name, this.listimageshow, this.statusAlbum});
  @override
  Allimages createState() => Allimages(
      name: name, listimageshow: listimageshow, statusAlbum: statusAlbum);
}

class Allimages extends State<ShowImage> {
  int optionSelected = 0;
  var statusAlbum;
  var name;
  var listimageshow; //อัลบั้มที่ผู้ใช้เลือก
  Allimages({this.name, this.listimageshow, required this.statusAlbum});

  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Image Page รับอะไรมาบ้าง ");
    print(name);
    print(listimageshow);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: MyStyle().blackColor,
            ),
            onPressed: () async {
              user_file user0 = new user_file();
              await user0.getdata_user_file();
              var user = await user0;

              var ListImgCloud;
              var listimageshow;
              if (await user.Login) {
                list_album la = new list_album();
                var ListImageDevice = await la.getimagefrom_api();
                print(
                    'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                //print(await la.listimageshow_device);
                listimageshow = await la.listimageshow;

                listimagecloud listimgC = new listimagecloud();
                ListImgCloud = await listimgC.getimagefrom_api();
                print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
                if (ListImgCloud != null && ListImgCloud.length != 0) {
                  for (int i = 0; i < ListImgCloud.length; i++) {
                    print(await ListImgCloud[i].geturlimage());
                  }
                }
              }
              var ListTag = [];
              ManageTag mnt = new ManageTag();
              ListTag = await mnt.getTagAlbum();

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FirstState(
                          page: 0,
                          user: user,
                          listimageshow: listimageshow,
                          ListImgCloud: ListImgCloud,
                          AllTagAlbum: ListTag)));
            },
          ),
          title: Text(
            this.name.toString(),
            style: TextStyle(
              fontSize: 30,
              color: MyStyle().blackColor,
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.normal,
              fontFamily: 'Rajdhani',
            ),
          ),
          //centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: MyStyle().whiteColor,
          actions: [
            IconButton(
              icon: Icon(
                Icons.restore,
                color: MyStyle().blackColor,
              ),
              onPressed: () async {
                var title = this.name;
                DBHelper db = DBHelper();
                await db.deletedata_intable();
                list_album listc = new list_album();
                await listc.getimagefrom_api();
                list_album listA = new list_album();

                var showDevice = await listA.getImag_inAlbum(title);
                print(showDevice);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            //ShowImage(name: title, selectbum: selectbum)
                            ShowImage(
                              name: title,
                              listimageshow: showDevice,
                            )));
                print("เลือกอัลบั้มที่ : ");
                print(title);
                print(showDevice);
                print(
                    "///////////////////////////////////////////////////////");
                /*DBHelper db = DBHelper();
                await db.deletedata_intable();
                user_file user = await new user_file();
                await user.getdata_user_file();
                var user0 = await user;
                var ListImgCloud0;
                var listimageshow;

                //

                if (await user.Login) {
                  list_album la = await new list_album();
                  await la.getimagefrom_api();
                  print(
                      'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                  listimageshow = await la.listimageshow;

                  listimagecloud listimgC = await new listimagecloud();
                  ListImgCloud = await listimgC.getimagefrom_api();
                  print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
                  if (ListImgCloud != null && ListImgCloud.length != 0) {
                    for (int i = 0; i < ListImgCloud.length; i++) {
                      print(await ListImgCloud[i].geturlimage());
                    }
                  }
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirstState(
                            page: 0,
                            user: user,
                            listimageshow: listimageshow,
                            ListImgCloud: ListImgCloud)));
             */
              },
            ),
            IconButton(
              icon: Icon(
                Icons.drive_file_move_outline,
                color: MyStyle().blackColor,
              ),
              onPressed: () {
                List<ImageData> imageListD = [];
                List<ImageData> imageListC = [];
                //imageList = ImageData.getImage();
                for (int i = 0; i < this.listimageshow["device"].length; i++) {
                  ImageData idt = ImageData(
                      this.listimageshow["device"][i]['img'] as String,
                      false,
                      i,
                      this.listimageshow["device"][i]['nameimg']);
                  imageListD.add(idt);
                }
                //var lenListD = imageListD.length;
                print(imageListD.length);
                print("******00*****");
                for (int i = 0; i < this.listimageshow["cloud"].length; i++) {
                  ImageData idtc = ImageData(
                      this.listimageshow["cloud"][i]['img'] as String,
                      false,
                      i,
                      this.listimageshow["cloud"][i]['nameimg']);
                  imageListD.add(idtc);
                }
                var lenListC = this.listimageshow["cloud"].length;
                var lenListD = this.listimageshow["device"].length;
                String statusitem = "Don't have";
                if (lenListC != 0 && lenListD != 0) {
                  statusitem = "Have 2";
                } else if (lenListC != 0 && lenListD == 0) {
                  statusitem = "Have 1 Cloud";
                } else if (lenListC == 0 && lenListD != 0) {
                  statusitem = "Have 1 Device";
                }
                print(imageListD.length);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectImageHomePage(
                              imageListD: imageListD,
                              lenListC: lenListC,
                              iconselect: "Delete",
                              statusitem: statusitem,
                              title: this.name,
                              /*iconselect: "delete"*/
                              /*iconselect: "delete"*/
                            )));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outline_outlined,
                color: MyStyle().blackColor,
              ),
              onPressed: () {
                List<ImageData> imageListD = [];
                List<ImageData> imageListC = [];
                //imageList = ImageData.getImage();
                for (int i = 0; i < this.listimageshow["device"].length; i++) {
                  ImageData idt = ImageData(
                      this.listimageshow["device"][i]['img'] as String,
                      false,
                      i,
                      this.listimageshow["device"][i]['nameimg']);
                  imageListD.add(idt);
                }
                //var lenListD = imageListD.length;
                print(imageListD.length);
                print("******00*****");
                for (int i = 0; i < this.listimageshow["cloud"].length; i++) {
                  ImageData idtc = ImageData(
                      this.listimageshow["cloud"][i]['img'] as String,
                      false,
                      i,
                      this.listimageshow["cloud"][i]['nameimg']);
                  imageListD.add(idtc);
                }
                var lenListC = this.listimageshow["cloud"].length;
                var lenListD = this.listimageshow["device"].length;
                String statusitem = "Don't have";
                if (lenListC != 0 && lenListD != 0) {
                  statusitem = "Have 2";
                } else if (lenListC != 0 && lenListD == 0) {
                  statusitem = "Have 1 Cloud";
                } else if (lenListC == 0 && lenListD != 0) {
                  statusitem = "Have 1 Device";
                }
                print(imageListD.length);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectImageHomePage(
                              imageListD: imageListD,
                              lenListC: lenListC,
                              iconselect: "Delete",
                              statusitem: statusitem,
                              title: this.name,
                              /*iconselect: "delete"*/
                              /*iconselect: "delete"*/
                            )));
              },
            ),
            if (statusAlbum == "Usercreate")
              IconButton(
                icon: Icon(
                  Icons.settings_outlined,
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

                  if (dataalbum[0]['IDENTITYALBUM'] != "Servercreate") {
                    var description = "";
                    var keyword = "";
                    if (dataalbum[0]['DESCRIPTIONALBUM'].length != 0) {
                      description = dataalbum[0]['DESCRIPTIONALBUM'];
                    }
                    if (dataalbum[0]['KEYWORDALBUM'].length != 0) {
                      //keyword = dataalbum[0]['KEYWORDALBUM'];
                      for (int i = 0;
                          i < dataalbum[0]['KEYWORDALBUM'].length;
                          ++i) {
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
                        title: this.name,
                        description: description,
                        keyword: keyword);
                  } else {
                    page = setting_Album_server(title: this.name);
                  }
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => page));
                },
              ),
          ],
        ),
        body: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          padding: EdgeInsets.all(8),
          childAspectRatio: 1 / 1.2,
          children: <Widget>[
            /*for (int i = 0; i < getPic.length; i++)
              _GridItem(
                getPic[i]['Namebum'] as String,
                img: getPic[i]['img'] as String,
                onTap: () => checkOption(i),
                selected: i == optionSelected,
                selectPic: i,
                name: name,
              )*/
            if (this.listimageshow != null)
              if (this.listimageshow["device"] != null)
                for (int i = 0; i < this.listimageshow["device"].length; i++)
                  _GridItem(
                      this.listimageshow["device"][i]['Namebum'] as String,
                      img: this.listimageshow["device"][i]['img'] as String,
                      onTap: () => checkOption(i + 1),
                      selected: i + 1 == optionSelected,
                      selectbum: i + 1,
                      listimageshow: listimageshow),
            if (this.listimageshow != null)
              if (this.listimageshow["cloud"] != null)
                for (int i = 0; i < this.listimageshow["cloud"].length; i++)
                  _GridItem_Cloud(
                    this.listimageshow["cloud"][i]['Namebum'] as String,
                    img: this.listimageshow["cloud"][i]['img'] as String,
                    onTap: () => checkOption(i + 1),
                    selected: i + 1 == optionSelected,
                    selectbum: i + 1,
                    listimageshow: listimageshow,
                  ),
          ],
        ));
  }
}

class _GridItem_Cloud extends StatelessWidget {
  const _GridItem_Cloud(
    this.title, {
    Key? key,
    required this.img,
    required this.selectbum,
    required this.onTap,
    required this.selected,
    required this.listimageshow,
  }) : super(key: key);

  final String title;
  final String img;
  final int selectbum;
  final VoidCallback onTap;
  final bool selected;
  final listimageshow;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: img,
        imageBuilder: (context, imageProvider) {
          return Ink.image(
            image: imageProvider,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SlideImage(
                            namealbumS: title,
                            selectpicS: img,
                            status: "cloud",
                            listimageshow: listimageshow)));
                print("รูปรวม ส่งไปที่ รูปใหญ่ : ");
                print(title);
                print(img);
                print(listimageshow);
                print(
                    "///////////////////////////////////////////////////////");
              },
            ),
          );
        });
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem(
    this.title, {
    Key? key,
    required this.img,
    required this.selectbum,
    required this.onTap,
    required this.selected,
    required this.listimageshow,
  }) : super(key: key);

  final String title;
  final String img;
  final int selectbum;
  final VoidCallback onTap;
  final bool selected;
  final listimageshow;
  @override
  Widget build(BuildContext context) {
    return Ink.image(
      fit: BoxFit.cover,
      image: FileImage(File(img)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SlideImage(
                      namealbumS: title,
                      selectpicS: img,
                      status: "device",
                      listimageshow: listimageshow)));
          print("รูปรวม ส่งไปที่ รูปใหญ่ : ");
          print(title);
          print(img);
          print(listimageshow);
          print("///////////////////////////////////////////////////////");
        },
      ),
    );
  }
}

class ImageData {
  String imageURL;
  bool isSelected;
  int id;
  var tokenphoto;

  ImageData(this.imageURL, this.isSelected, this.id, this.tokenphoto);
/*
  static List<ImageData> getImage() {
    return [
      ImageData('https://picsum.photos/200', false, 1),
      ImageData('https://picsum.photos/100', false, 2),
      ImageData('https://picsum.photos/300', false, 3),
      ImageData('https://picsum.photos/400', false, 4),
      ImageData('https://picsum.photos/500', false, 5),
      ImageData('https://picsum.photos/600', false, 6),
      ImageData('https://picsum.photos/700', false, 7),
      ImageData('https://picsum.photos/800', false, 8),
      ImageData('https://picsum.photos/900', false, 9),
    ];
  }*/
}
/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_photo_learn/Object/imagecloud.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImageSliderPage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';
import 'package:project_photo_learn/page/PagesF/first.dart';

import '../../Backend/User_data.dart';

// ignore: must_be_immutable
class ShowImage extends StatefulWidget {
  var name;
  var listimageshow;
  ShowImage({this.name, this.listimageshow});
  @override
  Allimages createState() =>
      Allimages(name: name, listimageshow: listimageshow);
}

class Allimages extends State<ShowImage> {
  int optionSelected = 0;
  var name;
  var listimageshow; //อัลบั้มที่ผู้ใช้เลือก
  Allimages({this.name, this.listimageshow});

  void checkOption(int index) {
    setState(() {
      optionSelected = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: MyStyle().blackColor,
            ),
            onPressed: () async {
              user_file user0 = new user_file();
              await user0.getdata_user_file();
              var user = await user0;

              var ListImgCloud;
              var listimageshow;
              if (await user.Login) {
                list_album la = new list_album();
                var ListImageDevice = await la.getimagefrom_api();
                print(
                    'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                //print(await la.listimageshow_device);
                listimageshow = await la.listimageshow;
                listimagecloud listimgC = new listimagecloud();
                ListImgCloud = await listimgC.getimagefrom_api();
                print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
                for (int i = 0; i < ListImgCloud.length; i++) {
                  print(await ListImgCloud[i].gettoString());
                }
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FirstState(
                          page: 0,
                          user: user,
                          listimageshow: listimageshow,
                          ListImgCloud: ListImgCloud)));
            },
          ),
          backgroundColor: MyStyle().whiteColor,
          title: Text(
            this.name,
            style: TextStyle(
              fontSize: 30,
              color: MyStyle().blackColor,
              fontWeight: FontWeight.bold,
              //fontStyle: FontStyle.normal,
              fontFamily: 'Rajdhani',
            ),
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                Icons.drive_file_move_outline,
                color: MyStyle().blackColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.delete_outlined,
                color: MyStyle().deleteColor,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: MyStyle().blackColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          padding: EdgeInsets.all(8),
          childAspectRatio: 1 / 1.2,
          children: <Widget>[
            /*for (int i = 0; i < getPic.length; i++)
              _GridItem(
                getPic[i]['Namebum'] as String,
                img: getPic[i]['img'] as String,
                onTap: () => checkOption(i),
                selected: i == optionSelected,
                selectPic: i,
                name: name,
              )*/
            if (this.listimageshow["device"] != null)
              for (int i = 0; i < this.listimageshow["device"].length; i++)
                _GridItem(this.listimageshow["device"][i]['Namebum'] as String,
                    img: this.listimageshow["device"][i]['img'] as String,
                    onTap: () => checkOption(i + 1),
                    selected: i + 1 == optionSelected,
                    selectbum: i + 1,
                    listimageshow: listimageshow),
          ],
        ));
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem(
    this.title, {
    Key? key,
    required this.img,
    required this.selectbum,
    required this.onTap,
    required this.selected,
    required this.listimageshow,
  }) : super(key: key);

  final String title;
  final String img;
  final int selectbum;
  final VoidCallback onTap;
  final bool selected;
  final listimageshow;
  @override
  Widget build(BuildContext context) {
    return Ink.image(
      fit: BoxFit.cover,
      image: FileImage(File(img)),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SlideImage(title: title, selectPic: listimageshow)));
          print("เลือกรูปที่ : ");
          print(title);
          print("///////////////////////////////////////////////////////");
        },
      ),
    );
  }
}*/
