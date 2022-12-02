import 'package:flutter/material.dart';
import 'package:fyp_survilence_system/screens/admin_dashboard/constants.dart';
import 'DriverChatListforAdmin.dart';
import 'OfficerChatListforAdmin.dart';


class TopNavBar extends StatefulWidget {
  const TopNavBar ({Key? key}) : super(key: key);

  @override
  State<TopNavBar > createState() => _TopNavBarState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _TopNavBarState extends State<TopNavBar>
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
        backgroundColor: Color(0xb00b679b),
        title: Text('Chat', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab( icon: Icon(Icons.account_circle_outlined),
                child: Text("Driver", style: TextStyle(
              fontSize: 14,fontWeight: FontWeight.bold))),
            Tab( icon: Icon(Icons.assured_workload_outlined),
                child:Text("Station Operator",style: TextStyle(
              fontSize: 14,fontWeight: FontWeight.bold))),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
              child: DriverChatListScreen(),
          ),
          Center(
            child: OfficerChatListScreen(),
          ),

        ],
      ),
    );
  }
}