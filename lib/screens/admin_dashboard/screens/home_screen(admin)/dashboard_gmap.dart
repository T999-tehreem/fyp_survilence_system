import 'package:flutter/material.dart';
import '../../../routes/g_map.dart';
import '../../constants.dart';

class StorageDetails extends StatefulWidget {
  const StorageDetails({Key? key}) : super(key: key);

  @override
  _StorageDetailsState createState() => _StorageDetailsState();
}

class _StorageDetailsState extends State<StorageDetails> {

  int? totalImg = 0;
  int? totalAudio = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 20, 5, 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 0.02),
      Positioned(
    top: 100,
    child:  Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
      ),
    height: MediaQuery.of(context).size.height*0.35,
    width: MediaQuery.of(context).size.width,

    child:
    GMap(),
          )
      )
          /*StorageInfoCard(
            svgSrc: "assets/icons/Documents.svg",
            title: "Audio Files",
            amountOfFiles: "1.3GB",
            numOfFiles: totalAudio,
          ),*/
      ]
      ),
    );
  }
}
