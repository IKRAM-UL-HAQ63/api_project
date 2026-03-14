import 'package:api_project/Get_API/dropdown_api.dart';
import 'package:api_project/Post_API/signup_login_api.dart';
import 'package:api_project/Post_API/upload_image.dart';
import 'package:flutter/material.dart';
import 'Get_API/exampl_five_api.dart';
import 'Get_API/example_four_api.dart';
import 'Get_API/example_three_api.dart';
import 'Get_API/example_two_api.dart';
import 'Get_API/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  DropdownAPI(),
    );
  }
}
