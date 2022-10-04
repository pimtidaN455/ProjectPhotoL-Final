// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:project_photo_learn/Sqfl/DBHelper.dart';

import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/ImagePage.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/manageimage_homt.dart';
import 'package:project_photo_learn/page/PagesF/PageHomeAlbum/places_data.dart';

enum DialogsAction { yes, cancel }

class AlertDialogs_Delete_img {
  static Future<DialogsAction> yesCancelDialog(BuildContext context,
      String title, String body, String nameAlbum, var imageListD) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(DialogsAction.cancel),
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              //onPressed: () => Navigator.of(context).pop(DialogsAction.yes),
              onPressed: () async {
                ////////
                manageimage_Home manage_img = new manageimage_Home();
                print("Delete");
                await manage_img.delete(imageListD, nameAlbum);

                //var title = this.title;
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
                              name: nameAlbum,
                              listimageshow: showDevice,
                            )));
                print("เลือกอัลบั้มที่ : ");
                print(title);
                print(showDevice);
                print(
                    "///////////////////////////////////////////////////////");
///////*//*
////*
                ///*
                /*  DBHelper db = DBHelper();
                await db.deletedata_intable();
                user_file user = await new user_file();
                await user.getdata_user_file();
                var user0 = await user;
                var ListImgCloud;
                var listimageshow;*/

                //
/*
                if (await user.Login) {
                  list_album la = await new list_album();
                  await la.getimagefrom_api();
                  print(
                      'LAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLaLAAaaaaaaaLa');
                  listimageshow = await la.listimageshow;

                  listimagecloud listimgC = await new listimagecloud();
                  ListImgCloud = await listimgC.getimagefrom_api();
                  print('\\\\\\\\\\\\\\\\\List\\\\\\\\\\\\\\\\');
                  /*for (int i = 0; i < ListImgCloud.length; i++) {
                      print(await ListImgCloud[i].geturlimage());
                    }*/
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FirstState(
                            page: 2,
                            user: user,
                            listimageshow: listimageshow,
                            ListImgCloud: ListImgCloud)));*/
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                    color: Color(0xFFC41A3B), fontWeight: FontWeight.w700),
              ),
            )
          ],
        );
      },
    );
    return (action != null) ? action : DialogsAction.cancel;
  }
}
