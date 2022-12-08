import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminTrackDriver extends StatefulWidget {
  var data;
  AdminTrackDriver({this.data});
  @override
  _AdminTrackDriverState createState() => _AdminTrackDriverState();
}

class _AdminTrackDriverState extends State<AdminTrackDriver> {
  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;
  double _originLatitude = 33.6043, _originLongitude = 73.0484;
  double _destLatitude = 33.6103, _destLongitude = 73.9009;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = 'AIzaSyA-F9moLzfO6nheP9hVOhH5wsRjNo8xr6U';
  GoogleMapController? mapController;

  @override
  void initState() {
    super.initState();
    location.enableBackgroundMode(enable: true);

    _originLatitude = widget.data['startlat'];
    _originLongitude = widget.data['startlng'];
    _destLatitude =widget.data['endlat'];
    _destLongitude = widget.data['endlng'];
    const oneSec = Duration(seconds: 2);

    _timer=  Timer.periodic(oneSec, (Timer t) => {getTrack()});

    // mapController = GoogleMap(initialCameraPosition: ()

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }
  Timer? _timer;

  Location location = new Location();
  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }


  getTrack() async {
    print("the id is ${widget.data.id}");
    //updatePinOnMap(widget.data['lat'],widget.data['lng']);
    await FirebaseFirestore.instance
        .collection('routes')
        .doc(widget.data.id)
        .get()
        .then((value) => {
      print("my lat is ${value['lat']}"),
      updatePinOnMap(value['lat'],value['lng'])
    });
     setState(() {});
  }

  /*bool isdriving = false;*/
  @override
  Widget build(BuildContext context) {

    ///updatePinOnMap(widget.data['lat'],widget.data['lng']);
    // _getPolyline();

    return SafeArea(
      child: Scaffold(
          /*persistentFooterButtons: [
            GestureDetector(
              onTap: () async {
                location.onLocationChanged
                    .listen((LocationData currentLocation) async {
                  print("im changing ${currentLocation.latitude}");
                  print(currentLocation.latitude);

                  // await FirebaseFirestore.instance
                  //     .collection('routes')
                  //     .doc('uoM1lVaRcyixXgDdBnIU')
                  //     .update({
                  //   'lat': currentLocation.latitude,
                  //   'lng': currentLocation.longitude
                  // });

                  isdriving = true;
                  setState(() {});
                  // Use current location
                });
              },
              child: Chip(
                label: Text(isdriving ? 'Start Driving' : 'Driving'),
              ),
            )
          ],*/
          body:
          Stack(
              children: [
                GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(_originLatitude, _originLongitude), zoom: 15),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: _onMapCreated,
            markers: Set<Marker>.of(markers.values),
            polylines: Set<Polyline>.of(polylines.values),
          ),
    ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff152e57),
          onPressed: () { Navigator.pop(context);},
          child: Icon(Icons.arrow_back, color: Colors.white,),
        ),
    ));
  }

  void _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
    Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    print("my results are");

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyDeLWzuC1YIVL5qSOEzHk7xWLhPGdvc4Bg',
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      //  travelMode: TravelMode.driving,
      // wayPoints: [PolylineWayPoint(location: "Rawalapindi, Islamabad")]
    );
    print("my results are ${result.points}");
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
  double CAMERA_ZOOM = 16;
  double CAMERA_TILT = 80;
  double CAMERA_BEARING = 30;
  Completer<GoogleMapController> _controller = Completer();

  void updatePinOnMap(lat,lng) async {

    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(lat,
          lng),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition = LatLng(lat,
          lng);

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      markers.removeWhere(
              (m,e) => e.markerId.value=='origin');
      _addMarker(LatLng(lat, lng), "origin",
          BitmapDescriptor.defaultMarker);
    });
  }
}
