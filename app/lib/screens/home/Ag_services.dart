import 'package:flutter/material.dart';
import 'package:agri2/widgets/chat_item.dart';
import 'package:agri2/util/data.dart';

import '../home/Agritech_services/weather.dart';
import 'Agritech_services/Extra.dart';
import 'Agritech_services/Tech_news.dart';
import 'Agritech_services/crop.dart';
import 'Agritech_services/soil.dart';
import 'Agritech_services/weather_page.dart';

class AgServices extends StatefulWidget {
  @override
  _AgServicesState createState() => _AgServicesState();
}

class _AgServicesState extends State<AgServices>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.green,
        shadowColor: Colors.black45,
        title: Text(
          "Services",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_list,color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.yellow,
          labelColor: Colors.yellow,
          unselectedLabelColor: Colors.white,
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              text: "News",
            ),
            Tab(
              text: "Soil Mgmt",
            ),
            Tab(
              text: "Weather",
            ),
            Tab(
              text: "Crop Mgmt",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          TechNews(),
          Soil_mgmt(),
          WeatherPage(),
          crop_mgmt(),


        ],
      ),

    );
  }

  @override
  bool get wantKeepAlive => true;
}
