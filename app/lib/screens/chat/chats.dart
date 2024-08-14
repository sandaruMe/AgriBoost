import 'package:flutter/material.dart';
import 'package:agri2/widgets/chat_item.dart';
import 'package:agri2/util/data.dart';

import '../home/Agritech_services/weather.dart';
import '../home/Agritech_services/weather_page.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats>
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
        title:Text("Services"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_list,
            ),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).colorScheme.secondary,
          labelColor: Theme.of(context).colorScheme.secondary,
          unselectedLabelColor: Theme.of(context).textTheme.bodySmall?.color,
          isScrollable: false,
          tabs: <Widget>[
            Tab(
              text: "Tech",
            ),
            Tab(
              text: "Soil",
            ),
            Tab(
              text: "Weather",
            ),
            Tab(
              text: "Extra",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[

          WeatherPage(),

        ],
      ),

    );
  }

  @override
  bool get wantKeepAlive => true;
}
