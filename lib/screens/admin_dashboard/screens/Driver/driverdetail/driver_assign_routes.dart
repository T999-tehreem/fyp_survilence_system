import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../routes/routedashboard/AssignRoutes.dart';

class DriverAssignPolylinesMap extends StatefulWidget {
  @override
  _DriverAssignPolylinesMapState createState() =>
      _DriverAssignPolylinesMapState();
}

class _DriverAssignPolylinesMapState extends State<DriverAssignPolylinesMap> {
  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;
  double _originLatitude = 33.6665915, _originLongitude = 73.071049199999;
  double _destLatitude = 33.6036188, _destLongitude = 73.0482751;
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

    // mapController = GoogleMap(initialCameraPosition: ()

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  gettrack() async {



  }
  Location location = new Location();

  bool isdriving = false;
  @override
  Widget build(BuildContext context) {
    // _getPolyline();

    return SafeArea(
      child: Scaffold(
          persistentFooterButtons: [
            GestureDetector(
              onTap: () async {
                location.onLocationChanged
                    .listen((LocationData currentLocation) async {
                  print("im changing ${currentLocation.latitude}");
                  print(currentLocation.latitude);

                  await FirebaseFirestore.instance
                      .collection('routes')
                      .doc('uoM1lVaRcyixXgDdBnIU')
                      .update({
                    'lat': currentLocation.latitude,
                    'lng': currentLocation.longitude
                  });

                  isdriving = true;
                  setState(() {});
                  // Use current location
                });
              },
              child: Chip(
                label: Text(isdriving ? 'Start Driving' : 'Driving'),
              ),
            )
          ],
          body: GoogleMap(
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
          )),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

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
}
