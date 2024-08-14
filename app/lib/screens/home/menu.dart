import 'package:flutter/material.dart';

import '../../screens/home/menu/user_profile.dart';

import 'menu/settings.dart';


class MenuPage extends StatelessWidget {

  String uid;
  MenuPage({Key? key, required this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        shadowColor: Colors.black45,
        title: Text(
          "Menu",
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[

          _buildMenuTile(
            context,
            Icons.person,
            'User Profile',
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfilePage(uid:this.uid)),);
                    //MaterialPageRoute(builder: (context) => VerifyAccountPage(email: "rm@gmail.com",phoneNumber: "0778839112")),);
            },
          ),
          _buildMenuTile(
            context,
            Icons.settings,
            'Settings',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),);
              // Navigate to settings page
            },
          ),

          _buildMenuTile(
            context,
            Icons.help,
            'Help & Support',
                () {
              // Navigate to help and support page
            },
          ),
          _buildMenuTile(
            context,
            Icons.event,
            'Events',
                () {
              // Navigate to events page
            },
          ),
          _buildMenuTile(
            context,
            Icons.logout,
            'Log Out',
                () {
              // Perform log out
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title, style: TextStyle(fontSize: 18.0)),
        onTap: onTap,
      ),
    );
  }
}


