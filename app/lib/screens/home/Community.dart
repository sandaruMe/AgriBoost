import 'package:flutter/material.dart';
import 'package:agri2/widgets/chat_item.dart';
import 'package:agri2/util/data.dart';

import '../home/Agritech_services/weather.dart';
import 'Community/friends.dart';
import 'Community/messages.dart';

class Community extends StatefulWidget {
  String uid;
  Community({Key? key, required this.uid}) : super(key: key);
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        shadowColor: Colors.black45,
        title: Text(
          "Community",
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
              text: "Frends",
            ),
            Tab(
              text: "Mesages",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          friends_get(uid: widget.uid),
          message_section(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
