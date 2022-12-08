import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../routes/g_map.dart';
import '../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StorageDetails extends StatefulWidget {
  const StorageDetails({Key? key}) : super(key: key);

  @override
  _StorageDetailsState createState() => _StorageDetailsState();
}

class _StorageDetailsState extends State<StorageDetails> {
  Stream<QuerySnapshot<Map<String, dynamic>>> routesInfo = FirebaseFirestore.instance.collection('routes').snapshots();
  int? totalImg = 0;
  int? totalAudio = 0;
  var markerIcon;
  getIcons() async {
    var icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 3.2), "assets/icon/drivericon.png");
    setState(() {
      markerIcon = icon;
    });
  }
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Set<Marker> googleMapMarkers = {};
  Map<String, dynamic> data = {};
  Future<dynamic> getfunction() async {
   // var myid = FirebaseAuth.instance.currentUser!.uid;
await   getIcons();

    try {
    var data=  await firestore
          .collection("routes")

          .get()
          .then((value) {
        if (kDebugMode) {
          print(value.docs);
        }

for(int i =0;i<value.docs.length;i++){

  Marker marker = Marker(
      markerId: MarkerId(value.docs[i].id.toString()),
    //  icon: markerIcon,
      position: LatLng(value.docs[i]['lat'], value.docs[i]['lng']),
      infoWindow: InfoWindow(
          title: '',
          onTap: () {

          }));
  if (mounted) {
    setState(() {
      googleMapMarkers.add(marker);
    });
  }

}

        });


       // data = value.docs;


      return data;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();

    getfunction();
  }
  Completer<GoogleMapController> _controller = Completer();



  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  @override
  Widget build(BuildContext context) {

    final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.596324, 73.0469951),
    zoom: 14.4746,
  );
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

    child:GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      markers: googleMapMarkers,

      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },


    ),
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
