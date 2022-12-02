import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:html/parser.dart' as parser;
import 'package:cloud_firestore/cloud_firestore.dart';

class DetectScreen extends StatefulWidget {
  DetectScreen();

  @override
  DetectScreenState createState() => new DetectScreenState();
}

class DetectScreenState extends State<DetectScreen> {
  File? selectedImage;
  File? second_Image;
  String? message = "";
  String? seat_belt="";
  String? bg_image = "";
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {

  }

  uploadImage() async{
    final request = http.MultipartRequest(
        "POST" , Uri.parse("https://bec2-111-68-99-41.in.ngrok.io/upload")
    );
    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile('image',
        selectedImage!.readAsBytes().asStream(),
        selectedImage!.lengthSync(),
        filename: selectedImage!.path.split("/").last));

    request.headers.addAll(headers);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    final resJson = jsonDecode(res.body);
    message = resJson['message'];
    seat_belt = resJson['message_2'];
    print(message);
    print(seat_belt);
    second_Image = selectedImage;

    setState(() {
      selectedImage = null;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            contentPadding: EdgeInsets.all(0.0),
            backgroundColor: Colors.white,
            scrollable: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.file(second_Image! ,
                    height: 150,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Results: ",
                        style: TextStyle(
                            color: Colors.cyan[800], fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Text(
                      message!,
                      style: TextStyle(
                          color: Colors.teal[900]
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Seat: ",
                        style: TextStyle(
                            color: Colors.cyan[800], fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Text(
                      seat_belt!,
                      style: TextStyle(
                          color: Colors.teal[900]
                      ),
                    )
                  ],
                ),

              ],
            ),
          );
        });
  }

  Future pickImage(ImageSource source) async {
    // var camerapermission = await Permission.camera;
    // var gallerypermission = await Permission.photos;
    // var image = await ImagePicker().pickImage(source: source);
    // if (image == null) return;
    // final imageTemporary = File(image.path);
    // image = imageTemporary as XFile?;
    // return image;

    final pickedImage =
    await ImagePicker().getImage(source: source , imageQuality: 85);
    selectedImage = File(pickedImage!.path);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white!.withOpacity(0.9),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Stack(children: [
                    selectedImage == null?
                  Container(
                  color: Colors.white,
                  )
                      :Container(
                      color: Colors.white,
                    ),


                    SingleChildScrollView(
                      child: Column(

                          children:[
                            SizedBox(
                              height: MediaQuery.of(context).size.height *0.2,
                            ),
                            selectedImage == null
                                ? Text("Please Select an Image to Upload" , style: TextStyle(
                                color: Colors.black
                            ),)
                            // : Image.file(selectedImage!),
                                :Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                              width: 160,
                              height: 160,
                            ),

                            SizedBox(height: MediaQuery.of(context).size.height *0.1,),
                            TextButton.icon(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(width: 1, color: Colors.black),
                                  ),),

                                  backgroundColor: MaterialStateProperty.all(Colors.white)
                              ),
                              onPressed:
                              uploadImage,

                              //selectedImage = null,
                              icon: Icon(Icons.upload_file , color: Colors.black,),
                              label: Text("Upload", style: TextStyle(
                                  color: Colors.black
                              ), ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height *0.04,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [Material(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.white , width: 2)
                                ),
                                elevation: 5,
                                color: Color(0xb00b679b),
                                child: MaterialButton(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  onPressed: () {
                                    pickImage(ImageSource.camera);
                                  },
                                  child: Column(
                                    children: [

                                      Text(" Camera",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),),
                                    ],
                                  ),
                                ),
                              ),
                                Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(color: Colors.white , width: 2)
                                  ),
                                  elevation: 5,
                                  color: Color(0xb00b679b),
                                  child: MaterialButton(

                                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    onPressed: () async {
                                      pickImage(ImageSource.gallery);
                                    },
                                    child: Column(
                                      children: [

                                        Text(" Gallery",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal),),
                                      ],
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ]
                      ),

                    ),
                  ]),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}