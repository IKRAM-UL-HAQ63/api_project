import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFourAPI extends StatefulWidget {
  const ExampleFourAPI({super.key});

  @override
  State<ExampleFourAPI> createState() => _ExampleFourAPIState();
}

class _ExampleFourAPIState extends State<ExampleFourAPI> {
  Future<List<dynamic>> getUserAPI() async {
    // ✅ Return the data
    final response = await http.get(
      Uri.parse("http://jsonplaceholder.typicode.com/users"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // ✅ Return instead of storing
    } else {
      throw Exception("Failed to load users");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get API Users"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder<List<dynamic>>(
        // ✅ Specify type
        future: getUserAPI(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data available"));
          }

          // ✅ Use snapshot.data directly
          final users = snapshot.data!;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ReusebleRow(
                        title: "Name",
                        value: users[index]["name"].toString(),
                      ),
                      ReusebleRow(
                        title: "Email",
                        value: users[index]["email"].toString(),
                      ),
                      ReusebleRow(
                        title: "Phone",
                        value: users[index]["phone"].toString(),
                      ),
                      ReusebleRow(
                        title: "Address",
                        value:
                            users[index]["address"]["street"].toString() +
                            ", " +
                            users[index]["address"]["geo"]["lng"].toString(),
                      ),
                      ReusebleRow(
                        title: "Website",
                        value: users[index]["website"].toString(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ReusebleRow extends StatelessWidget {
  String title, value;
  ReusebleRow({Key? key, required this.title, required this.value})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis, // Add ... if text is too long
            ),
          ),
        ],
      ),
    );
  }
}
