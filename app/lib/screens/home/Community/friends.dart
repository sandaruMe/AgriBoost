import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../chat/conversation.dart';
import 'friends_profile.dart';

class friends_get extends StatefulWidget {
  String uid;
  friends_get({Key? key, required this.uid}) : super(key: key);
  @override
  _friends_get createState() => _friends_get();
}

class _friends_get extends State<friends_get> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _userProfiles = [];
  bool _isLoading = true;

  final List<String> _items = List<String>.generate(10, (i) => 'User ${i + 1}');
  // List to track follow status for each item
  late List<bool> _isFollowing;


  void _toggleFollow(int index) {
    setState(() {
      _isFollowing[index] = !_isFollowing[index];
    });
  }

  @override
  void initState() {
    super.initState();
    _isFollowing = List<bool>.filled(_items.length, false);
    _loadUserProfiles();
  }

  Future<void> _loadUserProfiles() async {
    QuerySnapshot querySnapshot = await _firestore.collection('user_collection').get();
    List<Map<String, dynamic>> userDataList = querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();

    setState(() {
      _userProfiles = userDataList;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.separated(
        padding: EdgeInsets.all(10),
        separatorBuilder: (BuildContext context, int index) {
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width / 1.3,
              child: Divider(),
            ),
          );
        },
        itemCount: _userProfiles.length,
        itemBuilder: (BuildContext context, int index) {
          Map<String, dynamic> user = _userProfiles[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user['profileImageUrl'] ?? ''),
                radius: 25,
              ),
              contentPadding: EdgeInsets.all(0),
              title: Text(user['Firstname']+user['LastName'] ?? 'No Name'),
              subtitle: Text(user['status'] ?? 'No Status'),
              trailing: TextButton(
                onPressed: () => _toggleFollow(index),
                child: Text(
                  _isFollowing[index] ? 'Unfollow' : 'Follow',
                  style: TextStyle(
                    color: _isFollowing[index] ? Colors.red : Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => friends_profile(name:user['Firstname']+user['LastName'],country: user['Sountry'],imageUrl: user['profileImageUrl'],state:user['State'],job:'famers',uid: widget.uid, )),);
              },
            ),
          );
        },
      ),
    );
  }
}
