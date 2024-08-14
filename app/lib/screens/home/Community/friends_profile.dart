import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../services/databace_notification.dart';
import '../../../services/database_messages.dart';
import 'messages.dart';
class friends_profile extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String country;
  final String state;
  final String job;
  final String uid;


  friends_profile({
    required this.imageUrl,
    required this.name,
    required this.country,
    required this.state,
    required this.job,
    required this.uid,
  });

  @override
  State<friends_profile> createState() => _friends_profileState();
}

class _friends_profileState extends State<friends_profile> {


  Future<List<String>?> getUserData(String uid) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('user_collection')
          .doc(uid)
          .get();

      if (snapshot.exists) {
        String firstname = snapshot.get('Firstname') ?? '';
        String lastname = snapshot.get('LastName') ?? '';
        String dp = snapshot.get('profileImageUrl') ?? '';

        return [firstname + lastname, dp];
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (error) {
      print('Error retrieving user data: $error');
      return null;
    }
  }


  Future<void> addmesage(String name, String imageUrl) async {

    List<String>? userData  = await getUserData(widget.uid);
    String name_uder ='';
    String dp ='';
    if (userData != null && userData.length >= 2) {
      name_uder = userData[0];
      dp = userData[1];
    }

    String Doc_name ='${widget.uid}_${name}';

    await DatabaseService_mesaage(Doc_name: Doc_name)
        .updateUserData(name,imageUrl,"farmer");

    await notification_service(uid: (widget.uid))
        .updateUserData(name, "Add a post",dp);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => message_section()),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        shadowColor: Colors.black45,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(widget.imageUrl),
              ),
              SizedBox(height: 16.0),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '${widget.country}, ${widget.state}',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                widget.job,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  addmesage(widget.name,widget.imageUrl);
                  // Handle message button press
                },
                child: Text('Message'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                  textStyle: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
