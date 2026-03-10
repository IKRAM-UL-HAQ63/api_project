import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart%20';

class SignupLogin_API extends StatefulWidget {
  const SignupLogin_API({super.key});

  @override
  State<SignupLogin_API> createState() => _SignupLogin_APIState();
}

class _SignupLogin_APIState extends State<SignupLogin_API> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  void login(String email, String password) async {
    try {
      final response = await post(
        Uri.parse(
          "https://68b0fbe23b8db1ae9c055318.mockapi.io/api/v1/register",
        ),
        body: {"email": email, "password": password},
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print("Account created Successfully!");
      } else {
        print("Failed!");
      }
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post API"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailControler,
              decoration: InputDecoration(
                hintText: "email",
                labelText: "Email",
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              controller: passwordControler,
              decoration: InputDecoration(
                hintText: "password",
                labelText: "Password",
              ),
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                login(
                  emailControler.text.toString(),
                  passwordControler.text.toString(),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
