import 'dart:convert';

import 'package:api_project/Models/ProductsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFiveAPI extends StatefulWidget {
  const ExampleFiveAPI({super.key});

  @override
  State<ExampleFiveAPI> createState() => _ExampleFiveAPIState();
}

class _ExampleFiveAPIState extends State<ExampleFiveAPI> {
  Future<ProductsModel> getProductsAPI() async {
    final response = await http.get(
      Uri.parse("https://webhook.site/2b4f1d76-c4bc-4ba7-9041-f64d077e5439"),
    );
    var data1 = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data1);
    } else {
      return ProductsModel.fromJson(data1);
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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductsModel>(
              future: getProductsAPI(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                snapshot.data!.data![index].shop!.name
                                    .toString(),
                              ),
                              subtitle: Text(
                                snapshot.data!.data![index].shop!.shopemail
                                    .toString(),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  snapshot.data!.data![index].shop!.image
                                      .toString(),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * .3,
                              width: MediaQuery.of(context).size.width * 1,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    snapshot.data!.data![index].images!.length,
                                itemBuilder: (context, position) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          .25,
                                      width:
                                          MediaQuery.of(context).size.width *
                                          .5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            snapshot
                                                .data!
                                                .data![index]
                                                .images![position]
                                                .url
                                                .toString(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Icon(
                              snapshot.data!.data![index].inWishlist! == true
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
