// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:project_photo_learn/Sqfl/DBHelper.dart';
import 'package:project_photo_learn/my_style.dart';
import 'package:project_photo_learn/page/PagesF/PageSearch/tag_state.dart';

class Searchpage extends StatelessWidget {
  List<String> AllTagAlbum = [];
  Searchpage({
    required this.AllTagAlbum,
  });

  final controller = Get.put(TagStateController());
  final textController = TextEditingController();
  late double screen;
  //final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Search",
          style: TextStyle(
            fontSize: 30,
            color: MyStyle().whiteColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "\n   ใส่คำค้นหา",
          style: TextStyle(
            fontSize: 20,
            color: MyStyle().blackColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: textController,
              onEditingComplete: () {
                controller.listTagSearch.add(textController.text);
                textController.clear();
              },
              autofocus: false,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(fontStyle: FontStyle.italic),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'เพ่ิมคำที่คุณต้องการค้นหา',
                prefixIcon: Icon(Icons.tag),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (textController.text != "") {
                      controller.listTagSearch.add(textController.text);
                    }
                    textController.clear();
                  },
                  icon: const Icon(Icons.add),
                ),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
              ),
            ),
            suggestionsCallback: (String pattern) {
              return this.AllTagAlbum.where(
                  (e) => e.toLowerCase().contains(pattern.toLowerCase()));
            },
            onSuggestionSelected: (String suggestion) =>
                controller.listTagSearch.add(suggestion),
            itemBuilder: (BuildContext context, Object? itemData) {
              return ListTile(
                leading: Icon(Icons.tag),
                title: Text(itemData.toString()),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "   คำที่คุณต้องการต้นหาทั้งหมด ",
          style: TextStyle(
            fontSize: 20,
            color: MyStyle().blackColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rajdhani',
          ),
        ),
        Obx(() => controller.listTagSearch.length == 0
            ? Center(
                child: Text('\n ไม่มีคำที่คุณต้องการค้นหา'),
              )
            : Wrap(
                children: controller.listTagSearch
                    .map((element) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Chip(
                            label: Text(element),
                            deleteIcon: Icon(Icons.clear),
                            onDeleted: () =>
                                controller.listTagSearch.remove(element),
                          ),
                        ))
                    .toList(),
              )),
        Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            direction: Axis.horizontal,
            children: [
              buttonSearch(),
            ])
      ]),
    ));
  }

  Container buttonSearch() {
    return Container(
      margin: EdgeInsets.all(50.0),
      width: screen * 0.75,
      child: ElevatedButton(
        child: Text('Search'),
        onPressed: () async {
          ManageTag mnTag = new ManageTag();
          var Tag = await mnTag.getTagAlbum();
          print('--------------- Add Album ---------------');
          print(Tag);
        },
        style: ElevatedButton.styleFrom(
            primary: MyStyle().blackColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
