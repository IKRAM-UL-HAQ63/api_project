import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_project/Models/PostsModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostsModel> postList = [];
  Future<List<PostsModel>> getPostApi() async {

    // reponse contains
    // response = {
    //   statusCode: 200,
    //   body: '[{"userId":1,"id":1,"title":"...","body":"..."},{"userId":1,"id":2,...}]',
    //   headers: {...},
    //   reasonPhrase: "OK"
    // }

    final response = await http.get(
      (Uri.parse("http://jsonplaceholder.typicode.com/posts")),
    );
    //Before
    // String jsonText = '[{"id":1,"title":"Hello"},{"id":2,"title":"World"}]'
    // This is just text, you can't do jsonText[0] or access properties
    //After this --> var data = jsonDecode(response.body.toString());
    // List<Map> data = [
    //   {"id": 1, "title": "Hello"},
    //   {"id": 2, "title": "World"}
    // ]
    // Now you can do: data[0]["title"] → "Hello"

    //It converts the JSON string into Dart List/Map:

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get API"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Card(
                    child: ListView.builder(
                      itemCount: postList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Text(postList[index].id.toString()),
                            title: Text(postList[index].body.toString()),
                            subtitle: Text(postList[index].title.toString()),
                            trailing: Text(postList[index].userId.toString()),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
