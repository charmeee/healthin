import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

final List<String> healthtype = [
  "가슴",
  "등",
  "어깨",
  "팔",
  "배",
  "하체",
  "유산소",
];

class Exercise {
  int? id;
  String? name;
  String? enname;
  String? type;
  int? difficulty;
  List? content;
  List? precautions;
  // "id": ,
  // "name": "",
  // "enName": "",
  // "type": "",
  // "difficulty": 1,
  // "content": [
  // "",
  // ],
  // "Precautions": ["",]

  Exercise(
      {this.id,
      this.name,
      this.enname,
      this.type,
      this.difficulty,
      this.content,
      this.precautions});
  Exercise.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        enname = json['enname'],
        type = json['type'],
        difficulty = json['difficulty'],
        content = json['content'],
        precautions = json['precautions'];
}

class Dictionary extends StatefulWidget {
  Dictionary({Key? key}) : super(key: key);

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  var isSelected = List<bool>.filled(healthtype.length, false);
  FocusNode focusNode = FocusNode();
  String _searchText = "";
  List<Exercise>? machinedata = [];
  List<Exercise>? founddata = [];

  Future<void> readJson() async {
    //json파일 읽어오기
    final String response =
        await rootBundle.loadString('testjsonfile/healthmachinedata.json');
    //print(response.runtimeType);
    Map<String, dynamic> _machinedata = await jsonDecode(response);
    setState(() {
      machinedata = [
        ..._machinedata["items"].map((item) => Exercise.fromJson(item))
      ];
    });
  }

  void initState() {
    super.initState();
    readJson();
    founddata = [...machinedata!];
    //print(machinedata.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            height: 40,
            child: TextField(
              style: TextStyle(fontSize: 15),
              focusNode: focusNode,
              autofocus: false,
              keyboardType: TextInputType.text,
              onChanged: (text) {},
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                hintText: "운동을 검색해주세요",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.indigo),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Colors.indigo),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: healthtype.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 3, 10, 3),
                    child: ChoiceChip(
                      backgroundColor: Colors.indigo[50],
                      label: Container(
                          alignment: Alignment.center,
                          width: 40,
                          height: 30,
                          child: Text(healthtype[index])),
                      selected: isSelected[index],
                      onSelected: (bool value) {
                        setState(() {
                          isSelected =
                              List<bool>.filled(healthtype.length, false);
                          isSelected[index] = value;
                        });
                      },
                      labelStyle: TextStyle(
                          color:
                              isSelected[index] ? Colors.white : Colors.indigo),
                      selectedColor: Colors.indigo,
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              child: machinedata == null || machinedata!.isEmpty
                  ? Text("로딩중")
                  : ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        print(machinedata![0].name);
                        return ListTile(
                          title: Text(machinedata![index].name.toString()),
                        );
                      },
                      itemCount: machinedata!.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        height: 10,
                        color: Colors.indigo,
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
