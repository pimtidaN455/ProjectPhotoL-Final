import 'package:project_photo_learn/page/Backend/Use_Api.dart';

class manageimage_Home {
  delete(var listitem, var nameAlbum) {
    use_API api = new use_API();
    if (listitem.length != 0) {
      for (int i = 0; i < listitem.length; ++i) {
        print("****///*****");

        if (listitem[i].isSelected) {
          print(listitem[i].tokenphoto);
          api.Delete_image_incHome(listitem[i].tokenphoto, nameAlbum);
        }
      }
    }
  }

  move() {}
}
