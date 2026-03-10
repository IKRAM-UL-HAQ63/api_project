import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImages extends StatefulWidget {
  const UploadImages({super.key});

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      print("no image selected");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    // ✅ ADD: Log when starting
    print("🚀 Starting upload...");
    print("📁 File path: ${image!.path}");
    print("📊 File size: ${await image!.length()} bytes");

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse("https://fakestoreapi.com/products");
    // ✅ ADD: Log API endpoint
    print("🌐 Uploading to: $uri");

    var request = new http.MultipartRequest("POST", uri);

    request.fields["title"] = "Static title";
    var multipart = new http.MultipartFile("image", stream, length);
    request.files.add(multipart);
    // ✅ ADD: Log before sending
    print("📤 Sending request...");

    var response = await request.send();
    // ✅ ADD: Get response body
    var responseBody = await response.stream.bytesToString();

    // ✅ ADD: Detailed logging
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");
    print("📥 RESPONSE RECEIVED:");
    print("Status Code: ${response.statusCode}");
    print("Response Body: $responseBody");
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━");

    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() {
        showSpinner = false;
      });
      print("image uploaded");
    } else {
      print("failed");
      setState(() {
        showSpinner = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Upload Image"),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
          centerTitle: true,
          backgroundColor: Colors.indigo,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                child: image == null
                    ? Center(child: Text("Pick Image"))
                    : Container(
                        child: Center(
                          child: Image.file(
                            File(image!.path).absolute,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
            ),
            SizedBox(height: 100),
            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 100,
                color: Colors.green,
                child: Center(child: Text("upload")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
