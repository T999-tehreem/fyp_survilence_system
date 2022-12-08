import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/screens/routes/routedashboard/allRoutesInfo.dart';
import 'package:google_maps_pick_place/google_maps_pick_place.dart';
import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/utils/color.dart';
import '/utils/color.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../admin_dashboard/constants.dart';
import '../../routes/g_map.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:uuid/uuid.dart';


const kGoogleApiKey = 'AIzaSyA-F9moLzfO6nheP9hVOhH5wsRjNo8xr6U';
class UpdateRoutes extends StatefulWidget {
  dynamic data;
  UpdateRoutes({Key? key,this.data}) : super(key: key);

  @override
  State<UpdateRoutes> createState() => _UpdateRoutesState();
}

class _UpdateRoutesState extends State<UpdateRoutes> {
  var selectedCurrency;
  TextEditingController vehicleno = TextEditingController();
  TextEditingController driverID = TextEditingController();
  TextEditingController startlocation = TextEditingController();
  TextEditingController destination = TextEditingController();
  TextEditingController routes = TextEditingController();
  String? selectedValue;
  List<String> items = [
    'Route 1',
    'Route 2',
    'Route 3',
    'Route 4',
  ];
  Mode _mode = Mode.overlay;
  dynamic startlocationaddress,destinationlocationaddress;
  dynamic startlat,startlng,endlat,endlng;
  Future<void> _handlePressStartLocation() async {
    void onError(PlacesAutocompleteResponse response) {
      // print("response is ${response.}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    // show input autocomplete with selected mode
    // then get the Prediction selected
    final p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: 'en',
      components: [Component(Component.country, 'pak')],
    );
      final _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    final detail = await _places.getDetailsByPlaceId(p!.placeId!);
    final geometry = detail.result.geometry!;
    startlat = geometry.location.lat;
    startlng = geometry.location.lng;

    startlocation.text = p!.description.toString();
  }

  Future<void> _handlePressDestination() async {
    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    // show input autocomplete with selected mode
    // then get the Prediction selected
    final p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: 'en',
      components: [Component(Component.country, 'pak')],
    );
    final _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    final detail = await _places.getDetailsByPlaceId(p!.placeId!);
    final geometry = detail!.result.geometry!;
    endlat = geometry.location.lat;
    endlng = geometry.location.lng;

    destination.text = p!.description.toString();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vehicleno.text = widget.data['vehicleno'];
    driverID.text = widget.data['driverid'];

    startlocation.text = widget.data['startlocation'];

    destination.text = widget.data['destinationlocation'];

  }
  final Stream<QuerySnapshot<Map<String, dynamic>>> allDrivers =
  FirebaseFirestore.instance.collection('driver').snapshots();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          centerTitle: true, title: Text('Update Routes'),backgroundColor: Color(0xb00d4d79),),
      body: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Stack(
          children: [
            Container(  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xb00d4d79),Colors.white],
                    stops: [0.3, 0],
                  ),
                )),
            Positioned(
              top: 180,
              child:  Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child:
                GMap(),

              ),),
            Positioned(
              top: 30,
              left: 50,
              // bottom: 0,
              child:  Container(
                // alignment: Alignment.cen,
                //    height: 415,
                width: 270,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height:10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Routes",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ), Divider(color: Colors.red,),

                      const SizedBox(height:5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Text(
                            "Driver ID",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          ),],
                      ),
                      const SizedBox(height:5),
                      Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,

                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        child: Expanded(
                          child: StreamBuilder(
                            stream: allDrivers,
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                              if (!streamSnapshot.hasData)
                                return Center(child: Text("Loading....."));
                              else {
                                List<DropdownMenuItem<String>> currencyItems = [];
                                for (int i = 0;
                                i < streamSnapshot.data!.docs.length;
                                i++) {
                                  String snap =
                                  streamSnapshot.data!.docs[i]["driverId"];
                                  currencyItems.add(
                                    DropdownMenuItem(
                                      child: Text(
                                        snap,
                                        style: TextStyle(color: Color(0xff11b719)),
                                      ),
                                      value: "${snap}",
                                    ),
                                  );
                                }
                                return DropdownButton<String>(
                                  items: currencyItems,
                                  onChanged: (currencyValue) {
                                    final snackBar = SnackBar(
                                      content: Text(
                                        'Selected ID value is $currencyValue',
                                        style: TextStyle(color: Color(0xff11b719)),
                                      ),
                                    );
                                    setState(() {
                                      selectedCurrency = currencyValue;
                                      driverID.text = selectedCurrency;
                                    });
                                  },
                                  value: selectedCurrency,
                                  isExpanded: false,
                                  hint: new Text(
                                    "Choose Driver ID",
                                    style: TextStyle(color: Colors.black45, fontSize: 12),
                                  ),
                                );}
                            },
                          ),
                        ),
                      ),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children:[
                      //     TextFormField(
                      //       style: TextStyle(color: Colors.black),
                      //       controller: driverID,
                      //       decoration: InputDecoration(hintText: 'Driver ID',
                      //         hintStyle: TextStyle(fontSize:12,color: Colors.black45),
                      //         enabledBorder: OutlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.black),
                      //           borderRadius: BorderRadius. circular(10.0),
                      //         ),
                      //         isDense: true,
                      //         contentPadding: EdgeInsets.all(8),
                      //         focusedBorder:OutlineInputBorder(
                      //           borderSide: BorderSide(color: Colors.black),
                      //           borderRadius: BorderRadius. circular(10.0),),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Text(
                            "Start Location",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          ),
                        ],
                      ), const SizedBox(height:5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            controller: startlocation,
                            readOnly: false,
                            onTap: _handlePressStartLocation,
                            decoration: InputDecoration(
                              hintText: 'Start location',
                              hintStyle: TextStyle(
                                  fontSize: 12, color: Colors.black45),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.location_on,
                                  )),
                              isDense: true,

                              contentPadding: EdgeInsets.all(8),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height:10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:[
                          Text(
                            "Destination",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          ),],
                      ),
                      const SizedBox(height:5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            style: TextStyle(color: Colors.black),

                            onTap: _handlePressDestination,
                            controller: destination,
                            readOnly: false,
                            decoration: InputDecoration(
                                hintText: 'Destination',
                                hintStyle: TextStyle(
                                    fontSize: 12, color: Colors.black45),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.location_on,
                                    ))),
                          ),
                          const SizedBox(height: 15),
                          MaterialButton(
                            onPressed: () async {
                              if (vehicleno.text.isEmpty ||
                                  driverID.text.isEmpty ||
                                  startlocation.text.isEmpty||vehicleno.text.length>8) {
                                Fluttertoast.showToast(
                                    msg: "please fill all the fields first");

                                Fluttertoast.showToast(msg: 'Check your vehicle No it should be of 7 digits');
                              } else {
                                isloading = true;
                                setState(() {});

                                final _auth = FirebaseAuth.instance;
                                await FirebaseFirestore.instance
                                    .collection("routes")
                                    .add({
                                  'vehicleno': vehicleno.text.trim(),
                                  'driverid': driverID.text.trim(),
                                  'startlocation':
                                  startlocation.text.trim(),
                                  'destinationlocation':
                                  destination.text.trim(),
                                  'startlat': startlat,
                                  'startlng': startlng,
                                  'lat': startlat,
                                  'lng': startlng,
                                  'endlat': endlat,
                                  'endlng': endlng,
                                })
                                    .then((value) => {
                                  Fluttertoast.showToast(
                                      msg:
                                      "routes assigned successfully")
                                })
                                    .catchError((e) {
                                  Fluttertoast.showToast(msg: "error");
                                });
                                isloading = false;
                                setState(() {});
                              }
                            },
                            height: MediaQuery.of(context).size.height * 0.05,
                            minWidth: MediaQuery.of(context).size.width * 0.1,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                            ),
                            color: Color(0xff152e57),
                            child: const Text(
                              'Submit',
                              style:
                              TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height:5),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ), // your body content.
    );
  }
}