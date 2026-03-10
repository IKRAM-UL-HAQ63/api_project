import 'dart:convert';
import 'package:flutter/material.dart';
import '../Models/UsersModel.dart';
import 'package:http/http.dart' as http;

class ExampleThreeAPI extends StatefulWidget {
  const ExampleThreeAPI({super.key});

  @override
  State<ExampleThreeAPI> createState() => _ExampleThreeAPIState();
}

class _ExampleThreeAPIState extends State<ExampleThreeAPI> {
  List<UsersModel> usersList = [];
  Future<List<UsersModel>> getUsersApi() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        usersList.add(UsersModel.fromJson(i));
      }
      return usersList;
    } else {
      return usersList;
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
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUsersApi(),
              builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: usersList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReusebleRow(
                                title: "name",
                                value: snapshot.data![index].name.toString(),
                              ),
                              ReusebleRow(
                                title: "username",
                                value: snapshot.data![index].username
                                    .toString(),
                              ),
                              ReusebleRow(
                                title: "email",
                                value: snapshot.data![index].email.toString(),
                              ),
                              ReusebleRow(
                                title: "address",
                                value:
                                    snapshot.data![index].address!.city
                                        .toString() +
                                    "  " +
                                    snapshot.data![index].address!.geo!.lat
                                        .toString(),
                              ),
                            ],
                          ),
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

class ReusebleRow extends StatelessWidget {
  String title, value;
  ReusebleRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(value)],
    );
  }
}
