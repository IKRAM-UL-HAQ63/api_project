import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ExampleTwoAPI extends StatefulWidget {
  const ExampleTwoAPI({super.key});

  @override
  State<ExampleTwoAPI> createState() => _ExampleTwoAPIState();
}

class _ExampleTwoAPIState extends State<ExampleTwoAPI> {
  List<Photos> photosList = [];
  Future<List<Photos>> getPhotos() async {
    final response = await http.get(
      (Uri.parse("http://jsonplaceholder.typicode.com/photos")),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i["title"], url: i["url"], id: i["id"]);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get API"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
        centerTitle: true,
        backgroundColor: Colors.green[800],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: photosList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              snapshot.data![index].url.toString(),
                            ),
                          ),
                          title: Text(snapshot.data![index].title.toString()),
                          subtitle: Text(snapshot.data![index].id.toString()),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
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

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
