import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/screens/home_screen(admin)/dashboardicons.dart';
import '../../constants.dart';
import '../../responsive.dart';
import '../../../../screens/admin_dashboard/screens/home_screen(admin)/header.dart';
import 'dashboard_gmap.dart';

int totalAudio = 0;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(

          children: [
            const Header(),
            //const SizedBox(height: defaultPadding),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child:const StorageDetails(),
                )
              ],
            ), //const SizedBox(height: 0.001),
            DashboardIcons()

          ],
        ),
      ),
    );
  }
}
