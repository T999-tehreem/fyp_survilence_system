import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';

import '../chat/DriverChatListforAdmin.dart';
import '../chat/OfficerChatListforAdmin.dart';
import 'CompanyChallan.dart';
import 'DriverChallanHistory.dart';



class ChallanHistory extends StatefulWidget {
  const ChallanHistory ({Key? key}) : super(key: key);

  @override
  State<ChallanHistory > createState() => _ChallanHistoryState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _ChallanHistoryState extends State<ChallanHistory>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffAFE1AF),
        title: Text('Challan History', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab( icon: Icon(Icons.business_sharp),
                child: Text("Company", style: TextStyle(
                    fontSize: 14,fontWeight: FontWeight.bold))),
            Tab( icon: Icon(Icons.people_alt_rounded ),
                child:Text("Driver",style: TextStyle(
                    fontSize: 14,fontWeight: FontWeight.bold))),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            child: CompanyChallanScreen(),
          ),
          Center(
            child: DriverChallanScreen(),
          ),

        ],
      ),
    );
  }
}