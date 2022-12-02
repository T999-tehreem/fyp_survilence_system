// // ignore_for_file: deprecated_member_use
//
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:firebase/firebase.dart' as fb;
// import 'dart:html' as html;
//
// import 'package:image_picker_web/image_picker_web.dart';
//
// class UserImagePicker extends StatefulWidget {
//   UserImagePicker(this.imagePickFn);
//   final void Function(String pickedImage) imagePickFn;
//   @override
//   _UserImagePickerState createState() => _UserImagePickerState();
// }
//
// class _UserImagePickerState extends State<UserImagePicker> {
//   var _imageBool = false;
//   dynamic _pickedImage;
//
//   dynamic imageurl;
//
//   bool imageloading = false;
//   Future _pickImage() async {
//     Object? object = await ImagePickerWeb.getImageAsFile();
//     if (object is html.File) {
//       html.File imageFile = object;
//       if (imageFile != null) {
//         _pickedImage = imageFile.relativePath.toString();
//         debugPrint(imageFile.name.toString());
//         setState(() {
//           print(imageFile);
//           _imageBool = true;
//
//           print(_pickedImage);
//         });
//         //uploading it into firebase
//         setState(() {
//           imageloading = true;
//         });
//         fb.StorageReference storageRef = fb
//             .storage()
//             .ref('images/')
//             .child(DateTime.now().toString() + ".jpg");
//         fb.UploadTaskSnapshot uploadTaskSnapshot =
//             await storageRef.put(imageFile).future;
//
//         Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
//         print(imageUri);
//         imageurl = imageUri.toString();
//         widget.imagePickFn(imageurl);
//         setState(() {
//           imageloading = false;
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         imageloading
//             ? CircularProgressIndicator()
//             : FittedBox(
//                 child: Container(
//                   color: Theme.of(context).primaryColor,
//                   width: 150,
//                   height: 150,
//                   child: ClipRRect(
//                     borderRadius: new BorderRadius.circular(0.0),
//                     child: imageurl != null
//                         ? Image.network(
//                             imageurl,
//                             fit: BoxFit.fill,
//                           )
//                         : Container(),
//                   ),
//                 ),
//               ),
// //
//         FlatButton.icon(
//           textColor: Theme.of(context).primaryColor,
//           onPressed: _pickImage,
//           icon: Icon(
//             Icons.image,
//             color: Colors.white,
//           ),
//           label: Text(
//             "Add Image",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ],
//     );
//   }
// }
