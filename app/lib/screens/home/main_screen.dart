import 'package:agri2/screens/home/Community/friends.dart';
import 'package:flutter/material.dart';
import 'package:agri2/widgets/icon_badge.dart';
import 'package:agri2/screens/chat/chats.dart';

import 'package:agri2/screens/Home/home.dart';
import 'package:agri2/screens/home/notifications.dart';



import 'Ag_services.dart';
import 'Community.dart';
import 'market_place.dart';
import 'menu.dart';

class MainScreen extends StatefulWidget {
  String uid;
  MainScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          Home(uid: widget.uid),
          Community(uid: widget.uid),
          AgServices(),
          Market_place(uid: widget.uid),
          notifications_get(),
          MenuPage(uid: widget.uid)
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green, // Set your desired color here
        selectedItemColor: Colors.yellow, // Color for selected item
        unselectedItemColor: Colors.white, // Color for unselected items
        items: <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.design_services,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shop,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconBadge(icon: Icons.notifications),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '',
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
