import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:api_project/Models/DropdownModel.dart';
import 'package:http/http.dart' as http;

class DropdownAPI extends StatefulWidget {
  const DropdownAPI({super.key});

  @override
  State<DropdownAPI> createState() => _DropdownAPIState();
}

class _DropdownAPIState extends State<DropdownAPI> {
  Future<List<DropdownModel>> getPost() async {
    try {
      final response = await http.get(
        Uri.parse("http://jsonplaceholder.typicode.com/posts"),
      );
      final body = json.decode(response.body) as List;

      if (response.statusCode == 200) {
        return body.map((e) {
          final map1 = e as Map<String, dynamic>;
          return DropdownModel(
            userId: map1["userId"],
            id: map1["id"],
            title: map1["title"],
            body: map1["body"],
          );
        }).toList();
      }
    } on SocketException {
      throw Exception("No internet");
    }
    throw Exception("Error fetching data");
  }

  var selectedvalue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown API"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<List<DropdownModel>>(
              future: getPost(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButton(
                    isExpanded: true,
                    icon: Icon(Icons.add),
                    value: selectedvalue,
                    hint: Text("Select Value"),
                    items: snapshot.data!.map((e) {
                      return DropdownMenuItem(
                        value: e.title.toString() ,
                        child: Text(e.title.toString() + "   " +e.id.toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      selectedvalue = value;
                      setState(() {});
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
